//
//  RandomColorsVC.swift
//  RandomColors
//
//  Created by Ali Haider on 08/02/2023.
//

import UIKit

class RandomColorsVC: UIViewController {
    var color:[UIColor]=[] //step1.1
// MARK: REFACTOR - step 3.3 Avoid Identifier typing Mistakes using Enums
    enum Segue{
        static let toColorDetailsVC="ToColorDetailVC"
        
    }
    enum Cells{
        static let colorCell="tableViewCell"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addColor() //step 1.5

        // Do any additional setup after loading the view.
    }
    // MARK: REFACTOR - step 4.2 use static method
    //step 1.3
    func addColor(){
        for _ in 1...50{
            color.append(.random())
        }
    }

 // MARK: REFACTOR - step 3.1 put this method in another swift file and use it from there
    

 

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
//        let color=color[indexPath.row] //index value layay ga us row ka jis pay user tap karay
//        cell?.backgroundColor=color
//        return cell! //force unwraping
        
        //refactor above 4 lines
        guard let cell=tableView.dequeueReusableCell(withIdentifier:Cells.colorCell)else{
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
        
//        performSegue(withIdentifier: "ToColorDetailVC", sender: nil)
        
        //step 2.2:
//        pechlay statment main  segua color tap  karain tu aglay view pay lay k jaraha hay but is main koi data nhe but following statements pass data to next view
        let color=color[indexPath.row] //jis row pay tap karin us ka color lo
        performSegue(withIdentifier:Segue.toColorDetailsVC, sender: color)
        
        //jb sender argument set hogg tu ya function prepare() method ko automaticaly call karee gaee
    }
    
    //step 2.3
    /*segua data lay ka ayay ab us data ko nayay view nay receive karna hay jis ke leyaa following method zaroree ahy. yay function ColorDetails main mujod color optional type UIColor ko data assign karayee gee
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //distination UIViewController ko inherit karta hay
        // Is ko colorsDetails ke properties assign karnay ke layaa is ko ColorDetails main cast krnaa pday ga using "as" operator
        let destVC=segue.destination as! ColorsDetails
        destVC.color=sender as? UIColor // pass user tapped color to ColorsDetails
        
    }
    
    
    //CONITNUE: Colors Logic APp: //STEP 1
    //CONTINUE: Passing Data Logic  //STEP 2
    //CONTINUE: Refactoring Logic //STEP 3
}
