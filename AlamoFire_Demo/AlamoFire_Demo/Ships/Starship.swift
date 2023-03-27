//
//  Starship.swift
//  AlamoFire_Demo
//
//  Created by Qamar Abbas on 22/02/2023.
//

import Foundation
struct Starship: Decodable {
    
    let name:String
    let model:String
    let manufacturer:String
    let passengers:String
    let costInCredits:String
    let starShipClass:String
    let films:[String]
    
    
    enum CodingKeys: String, CodingKey{
        case name
        case model
        case manufacturer
        case costInCredits = "cost_in_credits"
        case passengers
        case starShipClass="starship_class"
        case films
    }
}

extension Starship: Displayable {
  var titleLabelText: String {
    name
  }
  
  var subtitleLabelText: String {
    model
  }
  
  var item1: (label: String, value: String) {
    ("MANUFACTURER", manufacturer)
  }
  
  var item2: (label: String, value: String) {
    ("COST", costInCredits)
  }
  
  var item3: (label: String, value: String) {
    ("Passengers", passengers)
  }
  
  var listTitle: String {
    "FILMS"
  }
  
  var listItems: [String] {
    films
  }
}

