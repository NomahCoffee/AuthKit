//
//  ExampleUser.swift
//  AuthKitExample
//
//  Created by Caleb Rudnicki on 7/13/21.
//

import Foundation
import AuthKit

class ExampleUser: AuthKitUser {
    
    var stripeID: String
    var cart: [CartItem]
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        stripeID = try values.decode(String.self, forKey: .stripeID)
        cart = try values.decode([CartItem].self, forKey: .cart)
        
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(stripeID, forKey: .stripeID)
        try container.encode(cart, forKey: .cart)
    }
    
    enum CodingKeys: String, CodingKey {
        case stripeID = "stripe_id"
        case cart
    }
    
}

struct CartItem: Codable {
    
    var id: Int
    var quantity: Int
    var coffee: Coffee
    
}

struct CoffeeList: Codable {
    let results: [Coffee]
}

public struct Coffee: Codable {
    
    var id: Int
    var created: String
    var name: String
    var price: Double
    var image: URL?
    var description: String
    var inStock: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case created
        case name
        case price
        case image
        case description
        case inStock = "in_stock"
    }
    
}

