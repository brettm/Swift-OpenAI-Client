//
//  OpenAIClient.swift
//  OpenAIClient
//
//  Created by Brett on 12/01/2023.
//
// Reference: https://beta.openai.com/docs/api-reference/completions/create

import Foundation

public class OpenAIClient {
    private let version: String
    private let hostURL: URL
    private var baseURL: URL {
        hostURL.appending(path: version)
    }
    private let session: URLSession
    private let apiKey: String
    private let orgId: String

    public init(
        apiKey: String,
        orgId: String,
        version: String = "v1",
        hostURL: URL = URL(string: "https://api.openai.com/")!,
        session: URLSession = URLSession.shared
    ) {
        self.apiKey = apiKey
        self.orgId = orgId
        self.version = version
        self.hostURL = hostURL
        self.session = session
    }
    
    public func fetch(_ service: OpenAIService) async throws -> (Data, URLResponse?) {
        var request = self.createRequest(for: service)
        request.httpMethod = service.httpMethod
        if request.httpMethod == "POST" {
            request.httpBody = try JSONEncoder().encode(service.model)
            return try await session.data(for: request)
        }
        return (Data(), nil)
    }

    private func createRequest(for service: OpenAIService) -> URLRequest {
        var request = URLRequest(url: service.url(host: self.baseURL))
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

