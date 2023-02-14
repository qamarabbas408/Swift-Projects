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
    
        //step3:
        let urlString:String
        //tag=0 refers to viewController we created in the storyboard execute if code
        //tag=1 refers to ViewController we created in AppDelegate.swift file execute else code
        if navigationController?.tabBarItem.tag == 0{
            urlString="https://www.hackingwithswift.com/samples/petitions-1.json"
        }
        else{
            //url containing updated feed of whitehouse petitions
            urlString="https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        if let url=URL(string: urlString){
            if let data=try?Data(contentsOf: url){
                parse(json: data)
                return
            }}
        showError()

    }
    

    func parse(json:Data){
        let decoder=JSONDecoder()
        
        if let jsonPetitions=try? decoder.decode(Petitions.self, from: json){
            petitions=jsonPetitions.results
            tableView.reloadData()
        }
    }

    //step4: showError() messages
    func showError(){
        let ac=UIAlertController(title: "Loading Error", message: "There was problem in HTTP request! Please Try Again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
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

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc=DetailViewController()
        vc.dataFromVC=petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
 

}

