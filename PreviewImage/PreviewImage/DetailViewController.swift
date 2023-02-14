//
//  DetailViewController.swift
//  PreviewImage
//
//  Created by Qamar Abbas on 09/02/2023.
//

import UIKit

class DetailViewController: UIViewController {
    //step5
    //IB :: InterfaceBuilder: it indicates a connection between IB and controller
    @IBOutlet var imageView: UIImageView!
    
    //step6
    //receiver to receive data
    var selectedImage:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //step12
        title=selectedImage
        //step14
        //badaa title use nhe karo
        navigationItem.largeTitleDisplayMode = .never
        
        //step 8
        //if array contains a string then load it in imageView Outlet of typeUI Image otherwise do nothing
        //optional binding 
        if let imageToLoad=selectedImage{
            imageView.image=UIImage(named:imageToLoad)
        }
    }
    
    //step 9
    //details view main navigationControls ko hide karnaa

    //agr user dobar tap kary tu hide karo
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap=true
        
    }
    //step 10
    // agr user tap karay to control dekhau
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap=false
    }
    
    
    

}
