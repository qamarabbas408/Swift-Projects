//
//  ColorsDetails.swift
//  RandomColors
//
//  Created by Ali Haider on 08/02/2023.
//

import UIKit


class ColorsDetails: UIViewController {
    //STEP 2:: RECEIVING DATA FROM RandomColorsVC
    //step 2.1
    var color:UIColor? // create optional to receive color  //remaiing steps are in RandomColorVC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //step 2.3 Use Passed Data here
        view.backgroundColor=color ?? UIColor.black //nil-coalecing
        /*nil-coalecing means : agr color ke value nil ho tu ?? operetor k bad wale property view pay apply karo karto other wise color ke agr koi value ho to wo view ke background py apply karo
         --> is ke jagaa optional chaining ya guard statement be use kyaa jastaktt hay
         */

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
