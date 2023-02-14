//
//  RandomColorsVC.swift
//  RandomColors
//
//  Created by Ali Haider on 08/02/2023.
//

import UIKit

class RandomColorsVC: UIViewController {
   
    //created Action outlet for a button
    @IBAction func temButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ToColorDetailVC", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
