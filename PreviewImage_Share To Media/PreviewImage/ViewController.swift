//
//  ViewController.swift
//  PreviewImage
//
//  Created by Qamar Abbas on 09/02/2023.
//

import UIKit

class ViewController: UITableViewController{
var pictures=[String]() //string type array of empty
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
         title="Storm Viewer"
  
        navigationController?.navigationBar.prefersLargeTitles=true

        
    
        let fm=FileManager.default
        let path=Bundle.main.resourcePath! //search project navigator directory
        print(path) //returns path of the project
        let items=try! fm.contentsOfDirectory(atPath: path) // look for content within in the project director
        for item in items{
            if item.hasPrefix("nssl"){
//                print(item) //display the name of image
                pictures.append(item)
                print("View")
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text=pictures[indexPath.row] //put the name of picture
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if let vc=storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            //select the image that is tapped
            vc.selectedImage=pictures[indexPath.row]
           
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    

}

