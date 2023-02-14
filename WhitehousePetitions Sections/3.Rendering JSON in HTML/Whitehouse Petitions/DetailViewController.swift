//
//  DetailViewController.swift
//  Whitehouse Petitions
//
//  Created by Qamar Abbas on 13/02/2023.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {
    //step4: create a variable that could hold data
    var dataFromVC:Petition?
    //step5: View Data in WebKit framework
    var webView:WKWebView?
    //assign webView to current Controller's view
    override func loadView() {
        webView=WKWebView()
        view=webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let dataFromVC = dataFromVC else {
            return
        }
        //step6: Render Data in HTML
        let htmlView="""
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
</head>
<body>
    <h4>\(dataFromVC.title)</h4>
    <p style="text-align:center">
    \(dataFromVC.body)
</p>
</body>
</html>
"""

        //step7: Render HTML
        webView?.loadHTMLString(htmlView, baseURL: nil)
        

        // Do any additional setup after loading the view.
    }
    
}
