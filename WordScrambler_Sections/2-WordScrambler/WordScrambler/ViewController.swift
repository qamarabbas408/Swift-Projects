//
//  ViewController.swift
//  WordScrambler
//
//  Created by Qamar Abbas on 10/02/2023.
//

import UIKit

class ViewController: UITableViewController {

    var allWords=[String]()
    var usedWords=[String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //step5: create a button in navigation Controller
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        

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
    
    func startGame(){
        //add a random word to view title
        title=allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text=usedWords[indexPath.row]
        return cell
    }
    
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
    func submit(_ answer:String){

        let lowerAnswer=answer.lowercased()
//step1: Feedback to player
        let errorTitle:String
        let errorMessage:String


        if isPossible(word:lowerAnswer){
            if isOriginal(word:lowerAnswer){
                if isReal(word:lowerAnswer){
                    usedWords.insert(lowerAnswer, at: 0)
                    let indexPath=IndexPath(row:0,section:0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    // if all functions return means no alert add the word to table view
                    return
                }
                //if word is not Real
                else{
                    errorTitle="Word not Recognized"
                    errorMessage="Please check your Spelling"
                }
            }
            // if word is not original
            else{
                errorTitle="Already Added"
                errorMessage="Sorry! This word is already used"
            }
        }
        //if word is not possible
        else{
            errorTitle="No Such Word"
            errorMessage="Extract the word from \"\(String(describing: title!.lowercased()))\" "
        }
        let ac=UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
        
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


