# OpenAIClient

A lightweight client for interacting with the OpenAI API.

NB This library currently only utilises the legacy completions endpoint, which can be used with the following models:
gpt-3.5-turbo-instruct, babbage-002, davinci-002

[More info here](https://platform.openai.com/docs/models/model-endpoint-compatibility)

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding OpenAIClient as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/brettm/swift-openai-client", .upToNextMajor(from: "0.0.1"))
]
```

## Example Useage

```swift
        let question = "What is the airspeed velocity of an unladen swallow"
        
        let client = OpenAIClient(apiKey: "XXX-YOUR_API_KEY-XXX", orgId: "XXX-YOUR_ORG_ID-XXX")
        let completionsModel = CompletionsModel(model: "davinci-002", prompt: [question], maxTokens: 128)
        let service = OpenAIService.completions(completionsModel)
        do {
            let (data, httpResponse) = try await service.request(client: client)
            guard
                httpResponse?.statusCode == 200,
                let completion = data as? CompletionsResponse,
                let answer = completion.choices.first
            else {
                // Check httpResponse for errors
                return
            }
            print(answer)
        }
        catch {
            print(error.localizedDescription)
        }
```
