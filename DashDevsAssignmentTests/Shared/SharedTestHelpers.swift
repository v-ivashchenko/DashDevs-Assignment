//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

var baseURL: URL {
    return URL(string: "https://base-url.com")!
}

var anyData: Data {
    return Data("any data".utf8)
}

var anyHTTPResponse: HTTPURLResponse {
    return HTTPURLResponse(statusCode: 0)
}

var successfulHTTPResponse: HTTPURLResponse {
    return HTTPURLResponse(statusCode: 200)
}

func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}

func makeJSON(_ json: [String: Any]) -> Data {
    return try! JSONSerialization.data(withJSONObject: json)
}
