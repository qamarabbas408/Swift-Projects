//
//  Petition.swift
//  Whitehouse Petitions
//
//  Created by Qamar Abbas on 13/02/2023.
//

import Foundation
//the Codable Protocol has implementations to parse JSON files
struct Petition:Codable{
    var title:String
    var body:String
    var signatureCount:Int
    
}
