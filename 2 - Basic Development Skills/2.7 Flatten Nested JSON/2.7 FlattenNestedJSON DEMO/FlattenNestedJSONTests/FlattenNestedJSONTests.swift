//
//  FlattenNestedJSONTests.swift
//  FlattenNestedJSONTests
//
//  Created by Paul Solt on 12/18/24.
//

import Testing
import Foundation

// Based on: https://www.donnywals.com/flattening-a-nested-json-response-into-a-single-struct-with-codable/

struct FlattenNestedJSONTests {

    let nestedJSONData = """
    {
      "id": 27,
      "contact_info": {
        "email": "paul@supereasyapps.com",
        "name": "Paul"
      },
      "preferences": {
        "contact": {
          "newsletter": true
        }
      }
    }
    """.data(using: .utf8)!

    @Test func parseNestedJSON() async throws {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // TODO: create Structs that are decodable
        _ = try decoder.decode(User.self, from: nestedJSONData)
    }

}

struct User: Decodable {
    let id: Int
    let email: String
    let name: String
    let isSubscribed: Bool

    enum CodingKeys: CodingKey {
        case id
        case contactInfo
        case preferences
    }

    struct ContactInfo: Decodable {
        let email: String
        let name: String
    }

    struct Preferences: Decodable {
        let contact: ContactPreferences

        struct ContactPreferences: Decodable {
            let newsletter: Bool
        }
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let contactInfo = try container.decode(ContactInfo.self, forKey: .contactInfo)
        let preferences = try container.decode(Preferences.self, forKey: .preferences)

        self.id = try container.decode(Int.self, forKey: .id)
        self.email = contactInfo.email
        self.name = contactInfo.name
        self.isSubscribed = preferences.contact.newsletter
    }
}
