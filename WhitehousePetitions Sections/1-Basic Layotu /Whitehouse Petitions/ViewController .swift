//
//  ViewController.swift
//  Whitehouse Petitions
//
//  Created by Qamar Abbas on 13/02/2023.
//

import UIKit
//step1: UI Layout
//step2: Create array to save Pettions
var petitions=[String]()
class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //step3.1: populate cells in view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    //step3.2 adding data to view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text="Some Title"
        cell.detailTextLabel?.text="Some Description"
        return cell
    }
    
 

}

