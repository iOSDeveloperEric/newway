//
//  SelectLevelVC.swift
//  DeepWorkProject
//
//  Created by Raj Patel on 23/04/25.
//

import UIKit

class SelectLevelVC: UIViewController {

    @IBOutlet weak var btnBegginer: UIButton!
    @IBOutlet weak var btnIntermediat: UIButton!
    @IBOutlet weak var btnExpert: UIButton!
    @IBOutlet weak var btnStartClasses: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnExpert.cornerRadiusCustom()
        btnIntermediat.cornerRadiusCustom()
        btnBegginer.cornerRadiusCustom()
        btnStartClasses.cornerRadiusCustom()
    }
    
    @IBAction func btnStartClasses(_ sender: Any) {
        let pathTo = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = pathTo.instantiateViewController(withIdentifier: "TabViewVC") as? TabViewVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
