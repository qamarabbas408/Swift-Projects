//
//  Films.swift
//  AlamoFire_Demo
//
//  Created by Qamar Abbas on 22/02/2023.
//

import Foundation
struct Films: Decodable {
  let count: Int
  let all: [Film]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}
