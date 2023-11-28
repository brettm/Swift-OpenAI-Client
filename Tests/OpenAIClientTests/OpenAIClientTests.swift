//
//  OpenAIClientTests.swift
//  OpenAIClientTests
//
//  Created by Brett on 12/01/2023.
//

import XCTest
@testable import OpenAIClient

// Replace these with valid keys for the integration tests to succeed
struct MockKeys {
    static let orgId = "XXX-YOUR_ORG_ID-XXX"
    static let apiKey = "XXX-YOUR_API_KEY-XXX"
}

final class OpenAIClientTests: XCTestCase {
    
    let orgId = MockKeys.orgId
    let apiKey = MockKeys.apiKey
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Test the integration with OpenAI API using a low cost model and parse the data.
    // Requires a valid API key and Organisation ID.
    // Useful for testing any changes made over time to the OpenAI model and also demonstrates its useage.
    func testing() async throws {
        let client = OpenAIClient(apiKey: apiKey, orgId: orgId)
        let completionsModel = CompletionsModel(model: "text-ada-001", prompt: ["Test"], maxTokens: 1)
        let service = OpenAIService.completions(completionsModel)
        do {
            let response = try await service.request(client: client)
            guard let httpResponse = response.1 else {
                XCTAssert(false, "Missing valid HTTPURLResponse")
                return
            }
            guard httpResponse.statusCode == 200 else {
                if httpResponse.statusCode == 401,
                   apiKey == MockKeys.apiKey || orgId == MockKeys.orgId {
                    XCTAssert(false, "Please add a valid API key/Org ID to successfully run this test")
                    return
                }
                XCTAssert(false, "Received an unexpected HTTP response code (\(httpResponse.statusCode)")
                return
            }
            guard let completion = response.0 else {
                XCTAssert(false, "Completion model is empty")
                return
            }
            print(completion)
            XCTAssert(true, "Received valid data and 200 HTTP status code:\n\n\(completion)")
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
}
