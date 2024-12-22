//
//  ComplexJSONLevelsDemoTests.swift
//  ComplexJSONLevelsDemoTests
//
//  Created by Paul Solt on 12/18/24.
//

import Testing
import Foundation

struct ComplexJSONLevelsDemoTests {

    func loadFile(filename: String, fileExtension: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: filename, ofType: fileExtension)!
        return NSData(contentsOfFile: path)

    }

    @Test func example() async throws {

        

    }

}

