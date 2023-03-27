//
//  ViewController.swift
//  GitHub Commits _ CoreData
//
//  Created by Qamar Abbas on 15/02/2023.
//

import UIKit
import CoreData //contains coreData classes
//MARK: DELETE CORE DATA
/* table views have default mehanic swipe to delete using tableView commit funciton
 Manged object context has delete() method that will delete object regardless of its type or location in the object graph. Once object is delete we call saveContext() method to write change back to persisitant store
 */
class ViewController: UITableViewController {
    /*  A predicate is a filter which you specify a critaria to select data that matches that crietaria */
    var commitPredicate:NSPredicate? //match a criteria or return nil
    
    var container:NSPersistentContainer! //create a container. This class provides us the options to load the data model and create a a database
    var commits=[Commit]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(changeFilter))
        
        container=NSPersistentContainer(name:"GithubCommits") //container and name should be same as coreData model
       
        //following method loads the saved DB if it exists, or creates otherwise
        //if error occurs it will return error otherwise model is loaded and ready to use
        container.loadPersistentStores {
            storeDescription, error in
            self.container.viewContext.mergePolicy=NSMergeByPropertyObjectTrumpMergePolicy //change the default behaiour of the container
            if let error = error {
                print("Unresolved Errro \(error)")
            }
        }
    
        //fetch commits
        performSelector(inBackground: #selector(fetchCommits), with: nil)
        
        //loadFetchedData on the View
        loadSavedData()
    }
    
    //filter method
    @objc func changeFilter(){
        let ac=UIAlertController(title: "Filter Commits", message: nil, preferredStyle: .alert)
        //Here are some predicates we can apply to our app
        //We want to request twelve commits twelve hours a go
        ac.addAction(UIAlertAction(title: "Show only Recent", style: .default){
            [unowned self] _ in
            let twelveHoursAgo=Date().addingTimeInterval(-43200) //43200 equal to half a day
            self.commitPredicate = NSPredicate(format: "date > %@", twelveHoursAgo as NSDate) // here %@ is a placeholder for value of date the date before > indicates the attribute of the Commit Model
            self.loadSavedData()
        })
        //lets request commits where message not begins with "some text"
        //NOT and BEGINSWITH are predicate rule
        ac.addAction(UIAlertAction(title: "Ignore Pull Requests", style: .default){
            [unowned self] _ in
            self.commitPredicate=NSPredicate(format: "NOT message BEGINSWITH 'Merge pul request' ")
            self.loadSavedData()
        })
        //lets filter requests where message contain fix or Fix word
        // contains is same as array but the subscript [c] indicates look for fix without considerign it case e.g fix and Fix or fiX all will be matched
        ac.addAction(UIAlertAction(title: "Show only Fixes", style: .default){
            [unowned self] _ in
            self.commitPredicate=NSPredicate(format: "message CONTAINS[c] 'fix'")
        })
        
        //show all commits
        ac.addAction(UIAlertAction(title: "Show All Commits", style: .default){
            [unowned self] _ in
            self.commitPredicate=nil
            self.loadSavedData()
        })
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac,animated: true)
    }
    //MARK: Step3: Delete Items Reapear
        /* when you run app multiple you notice that app download the records agin from the URL because, system by default is fetching entire data from the server. so if you delete some records in one build, then on next build app will download deeletd records again.
         /* here we will request server to return commits one second after our most recent commit and this can be sent to URL using "since" parameter to receive only the newest comits*/*/
   @objc func fetchCommits(){
       
       //part of step3:
       let newestCommitDate=getNewestCommitDate()
       
       
        if let data=try?String(contentsOf: URL(string: "https://api.github.com/repos/apple/swift/commits?per_page=100&since\(newestCommitDate)")!){
            //parseJSON is defined in SWiftyJSON class
            let jsonCommits=JSON(parseJSON: data)
            let jsonCommitArray=jsonCommits.arrayValue
            //Execute Following code in main queue
            DispatchQueue.main.async {
                [unowned self] in
                for jsdata in jsonCommitArray{
                    let commit=Commit(context: self.container.viewContext) //here we created object of Commit entity given us by NSPersistentContainer we created.
                    
                    //once data that is to be sent to model is properly configured
                    self.configure(commit:commit, usingJSON:jsdata) //configures data in RAM
                }
                self.saveContext() //once data is prepared insert into DB
                self.loadSavedData()
            }

        }
    }
    //MARK: Step4: Return comits where date is recent
    func getNewestCommitDate()->String{
        let formater=ISO8601DateFormatter()
        let newest=Commit.createFetchRequest() //prepare a new query
        let sort=NSSortDescriptor(key:"date",ascending: false) //newest commits
        newest.sortDescriptors=[sort]
        newest.fetchLimit=1
        
        if let commits=try? container.viewContext.fetch(newest){
            if commits.count>0{
                print(formater)
                return formater.string(from:commits[0].date.addingTimeInterval(1)) //add 1 second to the time from the previous commit, otherwise git will return newest comit again
            }
        } // if no valid date is found, the method returns date from 1st of jan 1970
        print(formater)
        return formater.string(from: Date(timeIntervalSince1970: 0))
    }
    
    func configure(commit:Commit, usingJSON jsonData:JSON){
        //add to model properties
        commit.sha=jsonData["sha"].stringValue //here sha is the key and is returned back in string type
        commit.message=jsonData["commit"]["message"].stringValue
        commit.url=jsonData["html_url"].stringValue
        //date has this format in JSON file 2023-02-15T04:46:37Z (called ISO-8601 FORMAT) thus it need further parsign
        let formatter=ISO8601DateFormatter() //it converts string as shown above into Date
        
        //nil collacing if date is in some other format return a default Date() object
    commit.date=formatter.date(from: jsonData["commit"]["committer"]["date"].stringValue) ?? Date()
        
        var commitAuthor:Author! //we are sure that each commit has a author. (Force Unwraping)
        let authorRequest=Author.createFetchRequest() //Preparing Fetch Request
        authorRequest.predicate=NSPredicate(format: "name == %@", jsonData["commit"].stringValue) //adding predicate to request
        //fetch the name  from jsonData  within commit{block}
        //next execute request if there are authors in Author entity
        if let authors = try? container.viewContext.fetch(authorRequest){
            if authors.count>0{
                commitAuthor=authors[0]
            }
        }
        //if commit block in json doesnt' have author name then add author from following JSON blocks
        if commitAuthor == nil{
            let author=Author(context: container.viewContext)
            author.name=jsonData["commit"]["committer"]["name"].stringValue
            author.email=jsonData["commit"]["commiter"]["email"].stringValue
            commitAuthor=author
            
        }
        commit.author=commitAuthor
    }
    
    
    
    // container obj provides a property called viewContext that provides an environment where we  can manipulate CoreData entirly in RAM/memory
    func saveContext(){
        if container.viewContext.hasChanges{
            do{
                //once changes are mode we call save() method to save data in the DB
                try container.viewContext.save()
            }catch{
                print("Error occured while Saving\(error)")
            }
        }
        
    }
    func loadSavedData(){
        let request=Commit.createFetchRequest()// create a select queery
        let sort=NSSortDescriptor(key:"date",ascending: false) // sort returned data based on newest firts3
        request.sortDescriptors=[sort] //add sort conditions to request querry
        
        request.predicate=commitPredicate
        //execute query
        do{
            commits=try container.viewContext.fetch(request) //execute query and fetch data if no error occurs
            print("Data Found: \(commits.count)")
            
            //call to tableView methods
            tableView.reloadData() // add data to table
        }
        catch{
            print("Failed to Fetch Records")
        }
    }

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Commit", for:indexPath)
        let commit=commits[indexPath.row]
        cell.textLabel!.text=commit.message
//        cell.detailTextLabel!.text=commit.date.description //description converts Date() type back to string
        cell.detailTextLabel!.text="By \(commit.author.name) on \(commit.date.description)"
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
           vc.detailItem=commits[indexPath.row] //selected row of commits array
           navigationController?.pushViewController(vc, animated: true) //put control to detail view
        } //storyboard view controoler
        //Target "Detail" storyBoard ID
    }
    //MARK: Step2: Create tableview commit method
    //fetch the row that user selects
    //remove it from the manged object context
    // remove it from the array
    //remove it from table view
    //save these changes to persistant store.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let commit=commits[indexPath.row]
            container.viewContext.delete(commit)
            commits.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            saveContext()
        }
    }

}

