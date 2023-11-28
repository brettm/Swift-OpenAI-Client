//
//  File.swift
//  
//
//  Created by Brett Meader on 28/11/2023.
//

import Foundation

public protocol Model: Encodable {}

public struct CompletionsModel: Model {
    var model: String
    var prompt: [String]?
    var maxTokens: Int?
    var temperature: Float?

    enum CodingKeys: String, CodingKey {
        case model
        case prompt
        case maxTokens = "max_tokens"
        case temperature
    }
    
    public init(model: String, prompt: [String]? = nil, maxTokens: Int? = nil, temperature: Float? = nil) {
        self.model = model
        self.prompt = prompt
        self.maxTokens = maxTokens
        self.temperature = temperature
    }
}

public struct Usage: Decodable {
    var promptTokens: Int
    var completionTokens: Int
    var totalTokens: Int

    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}

public struct Choice: Decodable {
    public var text: String
    public var index: Int
    public var logprobs: Int?
    public var finishReason: String

    enum CodingKeys: String, CodingKey {
        case text
        case index
        case logprobs
        case finishReason = "finish_reason"
    }
}

public protocol OpenAIResponse: Decodable { }

public struct CompletionsResponse: OpenAIResponse {
    public var id: String
    public var object: String
    public var model: String
    public var choices: [Choice]
    public var usage: Usage
}
