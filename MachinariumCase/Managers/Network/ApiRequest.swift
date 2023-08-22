//
//  ApiRequest.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

struct ApiRequest {
    let url: String
    let method: HTTPMethods
    let headers: [String: String]?
    let queryParams: [String: Any]?
    let body: Data?
}
