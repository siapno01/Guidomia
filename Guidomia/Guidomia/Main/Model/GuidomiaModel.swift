//
//  Model.swift
//  Guidomia
//
//  Created by michael.p.siapno on 11/13/21.
//

import Foundation

struct GuidomiaModel: Decodable {
    let consList: [String]
    let customerPrice: Int
    let make: String
    let marketPrice: Int
    let model: String
    let prosList: [String]
    let rating: Int
    
}
