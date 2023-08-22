//
//  NewsSourcesResponse.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

struct NewsSourcesResponse: Codable {
    let status: String?
    let sources: [NewsSource]?
}
