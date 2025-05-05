//
//  ViewController.swift
//  DeepWorkProject
//
//  Created by Raj Patel on 23/04/25.
//

import UIKit

class InitialVC: UIViewController {

    @IBOutlet weak var btnGetStart: UIButton! {
        didSet{
            btnGetStart.layer.cornerRadius      = btnGetStart.frame.height / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func getStartButtonClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}

