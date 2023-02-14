//
//  ViewController.swift
//  Whitehouse Petitions
//
//  Created by Qamar Abbas on 13/02/2023.
//

import UIKit
var petitions=[Petition]()
class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let url=URL(string: "https://www.hackingwithswift.com/samples/petitions-1.json"){
            if let data=try?Data(contentsOf: url){
               
                    parse(json: data)
            }
        }
    }
    

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
    //step1: Create a DetailsViewController
    //step2: Send Tapped cell data to DetailVC
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc=DetailViewController()
        vc.dataFromVC=petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
 

}

