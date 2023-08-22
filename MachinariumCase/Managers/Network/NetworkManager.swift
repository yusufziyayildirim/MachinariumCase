//
//  NetworkManager.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

protocol NetworkManager {
    func request<T: Codable>(_ api: ApiRequest, completion: @escaping (_ result: Result<T, Error>) -> Void)
}
