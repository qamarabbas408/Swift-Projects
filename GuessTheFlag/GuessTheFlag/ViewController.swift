//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Qamar Abbas on 10/02/2023.
//

import UIKit

class ViewController: UIViewController {

    //step1: Create outlets
    @IBOutlet var button3: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button1: UIButton!
    
    //step2: Create arrays to hold countries and scores
    var countries=[String]()
    var score=0
    
    //step8: create a variable that generate Int number between 0 and 2
    var correctAnswer=0
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //step3: //append countries array with values
        countries+=["Estonia","France","Ireland","Italy","Monaco","Nigeria","Poland","Russia","Spain","UK","US"]
        
        
        //step5: Call the askQuestions to see its effect on build
//        askQuestions()
        
        //step6: Now you have notice that flags with white colors are bit difficult to visualize
        //thus lets add a border width to imageView
        button1.layer.borderWidth=1 //add a black border around imageView
        button2.layer.borderWidth=1
        button3.layer.borderWidth=1
//        askQuestions()
        
        //step13
        askQuestions()
        
        
    }
    
    //step4: Create a function to populate imageViews from countries array
    //func askQuestions(){
    
    //step 14: Modify function parameter after step 13. The paramter execpts an UIAlertAction but it could also accept nil.
    func askQuestions(action:UIAlertAction! = nil){
        //step7: Shuffle array everytime we call askQUestion()
        countries.shuffle()
        //step9: Generate Random Numbers
        correctAnswer=Int.random(in: 0...2)
        
        
        button1.setImage(UIImage(named:countries[0]), for: .normal)
        button2.setImage(UIImage(named:countries[1]), for: .normal)
        button3.setImage(UIImage(named:countries[2]), for: .normal)
        
        //step10: return Country Name at tile attribute of view (top of screen) based on correctAnswer value
        //this title will ask question to select that country flag from flag list in view
        title=countries[correctAnswer].uppercased() //capitize  country name

    }
    //step11: Create ButtonAction Collection
    //this function will recognize each button using tag value which is set through story board of buttonView
    //if user title at top and country being selected matches then add a score otherwise minus the score
    //score is displayed in alertView each time flag is clicked
    //the sender argument means the button being selected which is identified by button tag property value
    @IBAction func buttonTaped(_ sender: UIButton) {
        //button1 :tag =0
        //button2 :tag =1
        //button3 : tag=2
        var title:String
        if sender.tag==correctAnswer{
            title="Correct"
            score+=1
        }
        else {
            title="Wrong"
            score-=1
        }
        
        //myown logic when user scores -5
        //if user scores -5 gameOver else
        if score == -5{
            let ac=UIAlertController(title: "Failed", message: "Your score is \(score)/5", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: askQuestions))
            present(ac,animated: true)
            score=0
        }
        else{
            //step12: Display the results in a alert with animation
            //create an alert showing score
            let ac=UIAlertController(title: title, message: "Your Score is \(score)", preferredStyle: .alert)
            //What happen when user taps the alert button
            //We want to call askQuestions() method to continue to play game
            //but the handler passes UIAlertAction to our method which doesn't has such parameter
            //thus we modified our function in step 13;
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestions))
            present(ac,animated: true)

        }
        
                
    
    }
    

}

