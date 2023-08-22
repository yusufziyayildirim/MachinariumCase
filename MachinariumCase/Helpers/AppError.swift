//
//  AppError.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

enum AppError: Error {
    case invalidURL
    case noHttpBody
    case httpFailure
    case decodingError
    case error(Error)
    case custom(String)
}
