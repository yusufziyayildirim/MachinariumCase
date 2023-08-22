//
//  News.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

struct News: Codable {
    let title, description, author: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let source: NewsSource?
}
