//
//  File.swift
//  
//
//  Created by Brett Meader on 28/11/2023.
//

import Foundation

public enum OpenAIService {

    case completions(CompletionsModel)

    internal var path: String {
        switch self {
        case .completions:
            return "completions"
        }
    }

    internal var httpMethod: String {
        switch self {
        case .completions:
            return "POST"
        }
    }

    internal var model: Model {
        switch self {
        case .completions(let model): return model
        }
    }

    internal func url(host: URL) -> URL {
        return host.appending(path: self.path)
    }

    public func request(client: OpenAIClient) async throws -> (OpenAIResponse?, HTTPURLResponse?) {
        let response = try await client.fetch(self)
        return (self.decode(response.0), response.1 as? HTTPURLResponse)
    }

    private func decode(_ data: Data) -> OpenAIResponse? {
        do {
            switch self {
            case .completions(_): return try JSONDecoder().decode(CompletionsResponse.self, from: data)
            }
        }
        catch {
            return nil
        }
    }
}
