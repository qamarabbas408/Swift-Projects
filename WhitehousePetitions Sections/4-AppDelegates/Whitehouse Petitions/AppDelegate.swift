//
//  AppDelegate.swift
//  Whitehouse Petitions
//
//  Created by Qamar Abbas on 13/02/2023.
//
//it controls how should system behave on events jysay app launch ho ya app background pay chalaa jayaay

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
//step1: UIWindow object
    var window: UIWindow? //its the window in which our app is running now. And window has a rootVIewController
    
    
    
    // MARK: IMPORTANT NOTE HERE:
    //app launch honay k baad application akheree configuration ke leyaa is method ko call kartee hay
        // us k badd application ke UI Load hotee hay
    //here we are creating another tapBarController
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //step2:
        //in storyboard we have embeded all controllers in TabBarController thus it is our rootViewCOntroller
        //here optional means window rootcontroler is tabBarControl which might not be in future. if it is the root controller the exectue {..statement }
        if let tabBarController=window?.rootViewController as? UITabBarController{
            // find the main.storyboard using UIStoryboard Class
            let storyboard=UIStoryboard(name:"Main",bundle: nil)
            
            //it instantiates the NavController which is the identifer we set in the storyboard
            let vc=storyboard.instantiateViewController(withIdentifier: "NavController")
              
            vc.tabBarItem=UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            tabBarController.viewControllers?.append(vc)
            
            //this whole code creates a duplicate code to create a viewController (view) wrapped inside naviagationController and gives it a new Tab bar item which can be distingushed from the existing tab using tag paramter and added these to list of viewCOntrollers
            //these controllers and controllers we created in storyboard are downloading same .json data thus creating two tabs pointless
            //but we can use two different URLs for .json data. One link contains updated data and other has a cached data means if live data URL is changed app can still access cached json store some other server
            //step3 in ViewController 
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

