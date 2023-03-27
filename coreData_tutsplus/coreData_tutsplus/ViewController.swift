//
//  ViewController.swift
//  coreData_tutsplus
//
//  Created by Qamar Abbas on 21/02/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let appDelegate=UIApplication.shared.delegate as! AppDelegate
    let appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setPersistentStore()
//        deleteData()
//        fetchData()
//        updateData()
        fetchData()
        
    }
    func setPersistentStore(){
        let context=appDelegate.persistentContainer.viewContext
        let entity=NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser=NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue("shouaib", forKey: "username")
        newUser.setValue("password", forKey: "password")
        newUser.setValue("qmarabbas715", forKey: "email")
        do{
            try context.save()
            debugPrint("Data is entered")
        }
        catch let error{
            debugPrint(error)
        }
    }
    func fetchData(){
        let context=appDelegate.persistentContainer.viewContext
        let request=NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //only wanted to fetch a single record
//        request.predicate=NSPredicate(format: "username=%@","shouaib")
        request.returnsObjectsAsFaults=false
        do{
            let result=try context.fetch(request)
            for data in result as! [NSManagedObject]{
                print(data.value(forKey: "username") as! String)
                print(data.value(forKey: "password") as! String)
            }
        }
        catch{
            print("Failed")
            debugPrint("No Data FOund")
        }
        
    }
    func updateData(){
        let context=appDelegate.persistentContainer.viewContext
        let request=NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //only wanted to fetch a single record
        request.predicate=NSPredicate(format: "username=%@","shouaib")
        do{
            let update=try context.fetch(request)
            let objectUpdate=update[0] as! NSManagedObject
            objectUpdate.setValue("Muhamad", forKey: "username")
            objectUpdate.setValue("New Password", forKey:"password")
            do{
                try context.save()
            }
            catch let error{
                debugPrint(error)
            }
            fetchData()
        }
        catch let error{
            debugPrint(error)
        }
        
    }
    func deleteData(){
        let context=appDelegate.persistentContainer.viewContext
        let request=NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        do{
            let deleteData=try context.fetch(request)
            let objToDelete=deleteData as! [NSManagedObject]
            for o in objToDelete {
                context.delete(o)
                debugPrint("Object Deleted: \(o)")
            }
            do{
                try context.save()
            }
            catch let error{
                debugPrint(error)
            }
        }
        catch let error{
            print(error)
        }
    }
 
 

}

