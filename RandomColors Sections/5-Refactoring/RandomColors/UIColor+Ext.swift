//
//  UIColor+Ext.swift
//  RandomColors
//
//  Created by Qamar Abbas on 09/02/2023.
//

import UIKit
extension UIColor{
    
    // MARK: REFACTOR - step 3.2
    //inorder to use this method in other controllers that inhert UIColor
    // we have to define it as static
    
    //step 1.4
    static func random()->UIColor{
        //CGFloat holds a number between 0 and 1 and alpha indicates opacity so 1 means no opacity same as in CSS
        let randomColor=UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        return randomColor
    }
}
