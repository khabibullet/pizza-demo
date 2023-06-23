//
//  ImageUrl.swift
//  pizza-demo
//
//  Created by Irek Khabibullin on 23.06.2023.
//

import Foundation

enum ImageUrl: Codable, Hashable {
    case local(String)
    case remote(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let url = try container.decode(String.self)
        self = .remote(url)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .local(let url), .remote(let url):
            try container.encode(url)
        }
    }
}
