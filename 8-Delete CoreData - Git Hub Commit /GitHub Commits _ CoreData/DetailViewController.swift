//
//  DetailViewController.swift
//  GitHub Commits _ CoreData
//
//  Created by Qamar Abbas on 15/02/2023.
//

import UIKit

class DetailViewController: UIViewController {
    var detailItem:Commit?
    @IBOutlet var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //message visible in label text
        if let detail=self.detailItem{
            detailLabel.text=detail.message //Assign message to UILabel
        }
        

    }
}
