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
      "id": 10,
      "contact_info": {
        "email": "test@test.com",
        "name": "Paul"
      },
      "preferences": {
        "contact": {
          "newsletter": true
        }
      }
    }
    """

    @Test func parseNestedJSON() async throws {

    }

}
