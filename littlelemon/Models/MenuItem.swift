//
//  MenuItem.swift
//  littlelemon
//
//  Created by yuriy on 5. 9. 25.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let price: String
//    // Optional extras:
//    let description: String?
//    let category: String?

    private enum CodingKeys: String, CodingKey {
        case title, image, price//, description, category
    }
}
