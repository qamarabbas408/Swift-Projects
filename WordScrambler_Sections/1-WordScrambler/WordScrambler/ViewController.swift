//
//  ViewController.swift
//  WordScrambler
//
//  Created by Qamar Abbas on 10/02/2023.
//

import UIKit

class ViewController: UITableViewController {
//step1: Create layout and add asset start.text into project naviagtor
//step 2: create arrays to store word and used Words
    var allWords=[String]()
    var usedWords=[String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //step5: create a button in navigation Controller
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        

//step3: read words from file and store them to array
        if let startWordsURL=Bundle.main.url(forResource: "start", withExtension: "txt") // look for a file of name start.txt
        {
            //startWordURL (file is if found then extract its content
            if let startWords=try? String(contentsOf:startWordsURL){
                allWords=startWords.components(separatedBy: "\n")
            }
        }
        //if is there is empty line in file then add
        if allWords.isEmpty{
            allWords=["silkworm"]
        }
        startGame()
        }
    
//step3: StartGame
    func startGame(){
        //add a random word to view title
        title=allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
//    //step4:create table cells based on size of usedWords.count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    //step5: set words to the Word identifier set in story board
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text=usedWords[indexPath.row]
        return cell
    }
    
    //step 6: Create function when button is clicked
    @objc func promptForAnswer(){
        //create alert controller object
        let ac=UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
            //add a text filed to alert
        ac.addTextField()
        //create a submit action
        //here we used trailing closure for handler argument
        //to aovid object-retain-cycle we made objects of UIAlertAction and UIAlertController weak
        let submitAction=UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in
            //reading text from the text-field
            guard let answer=ac?.textFields?[0].text else{
                return
            }
            self?.submit(answer)
            }
         
            //add above action scenario to ac in animated form
            ac.addAction(submitAction)
            present(ac,animated: true)
            
        }
    //step 7: display the word at top of tableView
    func submit(_ answer:String){
        //step8: add a word to table
//        usedWords.insert(answer,at:0) //insert word at first index of the array
//        let indexPath=IndexPath(row:0, section:0) //number would get index [0,0] means first cell of the array. The word you add is displayed at top of the tablewiew
//        print(indexPath)
//        tableView.insertRows(at: [indexPath], with: .automatic) //word addition will get an animation
        
        
//step9: add a word to table after validation
                let lowerAnswer=answer.lowercased()
        if isPossible(word:lowerAnswer){
            if isOriginal(word:lowerAnswer){
                if isReal(word:lowerAnswer){
                    usedWords.insert(lowerAnswer, at: 0)
                    let indexPath=IndexPath(row:0,section:0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }

        
    }
    // is main navigation controller k title k word ko submit action k word say compare karayaa ga
    // submit word ko letters main today ga ur phr ik ik letter ko title word k letter say compare karagay ga
    // agr submit word k sary letters title word say match honn tu return true else koi ik be match na ho tu false
    //yahn ya nhe  check karin ke submit word... dictionary ka koi word ho
    // for example:: title=consular , submitWord=sular >>> submit word exit karta hay title main but it doesn't have any meaning
    // meaning yay function check nhe karee gee
    func isPossible(word:String)->Bool{
        guard var tempword=title?.lowercased() else {return false}
        for letter in word{
            if let position=tempword.firstIndex(of: letter){
                tempword.remove(at:position)
            }
            else{
                return false
            }
    }
        return true
    }
    //if the word already exsits in usedWords array
    func isOriginal(word:String)->Bool{
        if !usedWords.contains(word){
            return true
        }
        else{
           return false
        }
     }
    
    //yahn English word ke spelling check hogie
    // iOS ke UITextChecker() use karin gay
    func isReal(word:String)->Bool{
        let checker=UITextChecker()
        let range=NSRange(location: 0, length: word.utf16.count) //calculates the length of the word enter in submit Action and converts it into unicode tranformation format -16 accested by NSRange which objective-C Construct
        let misspellRange=checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if misspellRange.location == NSNotFound {
            print("Word Exists")
            return true
        }
        else {
            print("No Such Word Exists")
            return false
        }
        
    }
}


