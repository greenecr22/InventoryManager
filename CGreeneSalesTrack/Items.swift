//
//  Items.swift
//  CGreeneSalesTrack
//
//  Created by Christopher Greene on 4/25/20.
//  Copyright © 2020 Christopher Greene. All rights reserved.
//

import Foundation

struct Items: Codable {
    var name: String!
    var size: String!
    var sku: String!
    var date: Date
    var cost: Double
    var value: Double
}
