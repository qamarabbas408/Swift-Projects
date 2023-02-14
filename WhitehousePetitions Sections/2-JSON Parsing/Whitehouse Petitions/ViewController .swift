//
//  ViewController.swift
//  Whitehouse Petitions
//
//  Created by Qamar Abbas on 13/02/2023.
//

import UIKit
//step1: UI Layout
//step2: Create two structures Petition and Petitions

//step3: Creat array of type Petition
var petitions=[Petition]()
class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
//step4: Send Request to Server and send data to a user function for decoding
        if let url=URL(string: "https://www.hackingwithswift.com/samples/petitions-1.json"){
            if let data=try?Data(contentsOf: url){
               
                    parse(json: data)
            }
        }
    }
    
    //step5: Decode JSON data came from Server
    //parse json
    func parse(json:Data){
        let decoder=JSONDecoder()
        
        if let jsonPetitions=try? decoder.decode(Petitions.self, from: json){
            petitions=jsonPetitions.results
            tableView.reloadData()
        }
    }

    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text=petitions[indexPath.row].title
        cell.detailTextLabel?.text=petitions[indexPath.row].body
        return cell
    }
    
 

}

//the Codable Protocol has implementations to parse JSON files
struct Petition:Codable{
    var title:String
    var body:String
    var signatureCount:Int
    
}

struct Petitions:Codable{
    var results:[Petition]
}
