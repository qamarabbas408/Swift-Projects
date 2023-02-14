//
//  RandomColorsVC.swift
//  RandomColors
//
//  Created by Ali Haider on 08/02/2023.
//

import UIKit

class RandomColorsVC: UIViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//for code readablity we can confrom deligate and datasource here
// we can also conform them on RandomColorsVC declared at top
//UITableViewDataSource: Provides cells for the Table View
//UIViewDelegate: Respond to row selections, swipes and other actions in rows
extension RandomColorsVC:UITableViewDelegate,UITableViewDataSource{
    
    // MARK: - Table Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //create 50 empty rows or protypeCells
        return 50
    }
    
    //delegate function. it is called automaticaly unlike functions that we created where we have to call them
    // this function is called eveytime a new row in the table is created
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell() //empty table view
    }
     
    //MARK: - TABLE DELEGATE METHODS
    //without this function nothing happens when you tapped a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToColorDetailVC", sender: nil)
    }
    
}
