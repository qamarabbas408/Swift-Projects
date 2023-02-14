//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Qamar Abbas on 10/02/2023.
//

import UIKit
//step1: Here we will create a simple browser. You pass URL of a site and main.storyboard shows the content of website like a browser and we can also add right and left gestures. for that we need WebKit framework
import WebKit

//step 4 conform to WKNavigationDelegate
class ViewController: UIViewController, WKNavigationDelegate {
    //step2: create WKWebView inherits UIView
    //this object add browser functionality inside apps UI
    //here we forced unrapped the object means we are sure that there is alwyas a URL
    var webView:WKWebView!
    
    //step3:: In all preivous programs we have seen viewDidLoad() loads at first but in this case swift loads function loadView() before viewDidLoad() to initialize the website web related variable before hand and then loads it on the UI
    //it doesn't matter where you place this func it will always load first.
    override func loadView() {
        //create instance of WKWebView() class
        webView=WKWebView()
        webView.navigationDelegate=self //assigning delegates to webView
        //above delegates will handle navigation actions and this line won't work unless step4
        
        //step5: Assign webView to root view
        view=webView //here we are assingin webView to our root view
        //this part here contains the web content of the URL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //step6:
        //remember in swift url are of type URL datatype
        let url = URL(string:"https://www.google.com")!
        webView.load(URLRequest(url:url))
        webView.allowsBackForwardNavigationGestures=true
    }
    

}

