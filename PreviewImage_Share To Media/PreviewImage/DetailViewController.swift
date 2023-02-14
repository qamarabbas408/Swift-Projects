//
//  DetailViewController.swift
//  PreviewImage
//
//  Created by Qamar Abbas on 09/02/2023.
//

import UIKit
class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        title=selectedImage

        navigationItem.largeTitleDisplayMode = .never
        
        // step1: create share button and set a target for that button
        //the code before equal indicates a share button is created at right-side of view
        //code after = indicates a class initialized with arguments
        // .action indicates this button will perform some action
        // target: indicates the the code that is to be called is within this DetailViewController class.
        // action: indicates the function or code that will be executed. #selector indicates the function is objective-c object
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        
        if let imageToLoad=selectedImage{
            imageView.image=UIImage(named:imageToLoad)
        }
    }
     //step2: what to share when button is tapped
    @objc func shareButtonTapped(){
        
        //step3: passing nothing to UIActivityCOntroller
        //UIActivityController automaticaly gives us the functionality to share by iMessage, email , by twitter and by facebook.
        // also gives us option to save image to photo library, assinging it to contact, print out via AirPrint and moer,
//        let vc = UIActivityViewController(activityItems: [], applicationActivities: []) // we created object of UIAcitvityViewController with items to share as arguments
//        vc.popoverPresentationController?.barButtonItem=navigationItem.rightBarButtonItem //object will call popoverPresentationController (a controller that controls pop outs )
//        present(vc,animated: true)
        
        
        //step4: passing image to UIActivityController
        //imageView outlet has image optional called jpegData() which has one paraemter specifies quality of image between 0 and 1
        guard let image=imageView.image?.jpegData(compressionQuality: 0.8) else{
           print("No Such Image")
           return
        }
    //share image to UIActivityController
    let vc=UIActivityViewController(activityItems: [image], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem=navigationItem.rightBarButtonItem //assign popover screen to navigation button
        present(vc,animated:true) //show popover screenw with an animation
        
        
        //step5: is code say image share karnay k options ayain gay but
        //image ko files ya kisi photos librrary main save nhe kyaa jasaktaa hay
        //Imge ko file ya library main save karnaa ke info.plist file k configuration chanage karnee hogee
        //file main ja k information Proeprty List pay right click kr privacy-Phot0 Library .. key ko select krain ur value main us ke description add krain ke tasveer q save krrhain hain.
        

}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap=true
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap=false
    }
    
    
    

}
