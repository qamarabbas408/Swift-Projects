//
//  RandomColorsVC.swift
//  RandomColors
//
//  Created by Ali Haider on 08/02/2023.
//

import UIKit

class RandomColorsVC: UIViewController {
    var color:[UIColor]=[] //step1.1

    override func viewDidLoad() {
        super.viewDidLoad()
        addColor() //step 1.5

        // Do any additional setup after loading the view.
    }
    
    //step 1.3
    func addColor(){
        for _ in 1...50{
            color.append(createRandomColor())
        }
    }
    
    //step 1.4
    func createRandomColor()->UIColor{
        //CGFloat holds a number between 0 and 1 and alpha indicates opacity so 1 means no opacity same as in CSS
        let randomColor=UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        return randomColor
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
//        return 50
        //step 1.6
        //Now we have creted an array holding 50 color so instead hardcoding value we can use
        return color.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell() //empty table view
        
        //step 1.7
        //previously this method return empty table views (empty cells) but now we  will populate our array to the table
        // for that we have to create an identifier from main storyboard against a table view cell/prototype cell only then we can target
        /* dequeResuableCell(): jb is app ko run kartain hain tu screen pay cells/rows nazar atain hain
         ur jb screen ko swip kartain hain tu ap ko nechay ur cells nazar atain hain ab tb tk swip kartay ho jb tk color.count pura na ho jo is case main 50 cells hay. dequeMethod() wo cells jo swip ho k uper gayay hain unhee ko reuse  (har dafa nayay cell create nhe kartee hay) kar k screen pay dekhtee jo is waqt user dekh rhaa hotaa hay.
         -->ur is ka return type optional hotaa hay
         -->yay do paramters lay gee 1. identifier of cell 2. indexPath which can be ignored
         */
        
//        let cell=tableView.dequeueReusableCell(withIdentifier: "tableViewCell")
//        let color=color[indexPath.row] //index path har row ka index fetch kartaa hay
//        cell?.backgroundColor=color
//        return cell! //force unwraping
        
        //refactor above 4 lines
        guard let cell=tableView.dequeueReusableCell(withIdentifier: "tableViewCell")else{
            return UITableViewCell() //empty cell view in case optional has nil
        }
        //otherwise
        cell.backgroundColor=color[indexPath.row]
        
        return cell
        
    }
     
    //MARK: - TABLE DELEGATE METHODS
    //delegate function. it is called automaticaly unlike functions that we created where we have to call them manualy or explicitly
    // this function is called eveytime a new row in the table is created
    //without this function nothing happens when you tapped a row
    //this function perform segua sending control from RandomColorVC to ColorDetailsVC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToColorDetailVC", sender: nil)
    }
    
    //CONITNUE: Colors Logic APp: //STEP 1 initialize empty array to hold colors
}
