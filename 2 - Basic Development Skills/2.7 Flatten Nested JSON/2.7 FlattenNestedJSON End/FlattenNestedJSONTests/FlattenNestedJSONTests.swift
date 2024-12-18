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
    """.data(using: .utf8)

    @Test func parseNestedJSON() async throws {

    }

}
