//
//  Starships.swift
//  AlamoFire_Demo
//
//  Created by Qamar Abbas on 22/02/2023.
//

import Foundation
struct Starships:Decodable{
    var count:Int
    var all:[Starship]

    enum CodingKeys: String, CodingKey{
     case count
    case all="results"
    }
}

