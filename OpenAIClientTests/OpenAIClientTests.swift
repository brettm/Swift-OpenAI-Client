//
//  OpenAIClientTests.swift
//  OpenAIClientTests
//
//  Created by Brett on 12/01/2023.
//

import XCTest
@testable import OpenAIClient

final class OpenAIClientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testing() async throws {
        let client = OpenAPIClient()
        let completionsModel = CompletionsModel(model: "text-ada-001", prompt: ["Test"], maxTokens: 1)
        let service = OpenAPI.completions(completionsModel)
        do {
            let response = try await service.request(client: client)
            print(response)
        }
        catch {
            print(error)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
