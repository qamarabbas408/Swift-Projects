//
//  ViewController.swift
//  PreviewImage
//
//  Created by Qamar Abbas on 09/02/2023.
//

import UIKit
//step 2
//change controller UIViewController to UITableViewController
//class ViewController: UIViewController {
//UITableViewController creates a tableview on screen it self
class ViewController: UITableViewController{
var pictures=[String]() //string type array of empty
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //step11 : Assign title to controller
         title="Storm Viewer"
        //step 13
        //wanted to use large title
        navigationController?.navigationBar.prefersLargeTitles=true

        
        //Step 1
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
    
    //step 3: How many rows does a table have
    // populate each row in picture name
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
        
    }
    //step 4: Populate rows  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text=pictures[indexPath.row] //put the name of picture
        return cell
    }
    
    //step7: Send Image Data to DetailViewController
    // send the image data of row which user tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //optional chaining
        //instantiate a viewController with a identifier if existss otherwise do nothing
        if let vc=storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            //select the image that is tapped
            vc.selectedImage=pictures[indexPath.row]
            //send control to child controller vc if exists otherwise do nothing if no such child controller
            //animated:false means send to next page without an animation
            // and also won't be able to swipe back
            //you have to use navigation back button
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    

}

