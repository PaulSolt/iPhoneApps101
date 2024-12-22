//
//  convertFromSnakeCaseTests.swift
//  convertFromSnakeCaseTests
//
//  Created by Paul Solt on 12/17/24.
//

import Foundation
import Testing

// Based on: https://stackoverflow.com/questions/49881621/the-convertfromsnakecase-strategy-doesnt-work-with-custom-codingkeys-in-swi

struct convertFromSnakeCaseTests {
    let studentData = """
    {
      "student_id": "123",
      "name": "Paul Solt",
      "test_score": 94.5
    }
    """.data(using: .utf8)!

    let studentWorkerData = """
    {
      "student_id": "123",
      "name": "Paul Solt",
      "is_active": false
    }
    """.data(using: .utf8)!

    @Test func example() async throws {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase // testScore <- test_score, studentId <- student_id
        let student = try decoder.decode(Student.self, from: studentData)

        print(student)
        #expect(student.name == "Paul Solt")
        #expect(student.studentID == "123")
        #expect(student.testScore == 94.5)
    }

    @Test func testStudentWorkParses() async throws {
        let decoder = JSONDecoder()
        let studentWorker = try decoder.decode(StudentWorker.self, from: studentWorkerData)

        #expect(studentWorker.name == "Paul Solt")
        #expect(studentWorker.studentID == "123")
        #expect(studentWorker.isActive == false)
    }
}

struct Student: Codable {
    let studentID: String // let studentID: String == ERROR!!! (not found)
    let name: String
    let testScore: Double

    enum CodingKeys: String, CodingKey {
//        case studentID = "studentId" // not "student_id" when using .convertFromSnakeCase
        case studentID = "student_id" // using .default .keyDecodingStrategy
        case name
        case testScore = "test_score"
    }
}

struct StudentWorker: Codable {
    let studentID: String
    let name: String
    let isActive: Bool

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.studentID = try container.decode(String.self, forKey: .studentID)
        self.name = try container.decode(String.self, forKey: .name)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
    }

    enum CodingKeys: String, CodingKey {
        case studentID = "student_id" // using .default .keyDecodingStrategy
        case name
        case isActive = "is_active"
    }
}
