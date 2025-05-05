//
//  LoginVC.swift
//  DeepWorkProject
//
//  Created by Raj Patel on 23/04/25.
//

import UIKit

class LoginVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var btnFacebook: UIButton! {
        didSet{
            btnFacebook.layer.cornerRadius      = btnFacebook.frame.height / 2
        }
    }
    @IBOutlet weak var btnGoogle: UIButton!{
        didSet{
            btnGoogle.layer.cornerRadius      = btnGoogle.frame.height / 2
        }
    }
    @IBOutlet weak var txtEmailField: UITextField! {
        didSet{
            txtEmailField.layer.cornerRadius        = txtEmailField.frame.height / 2
            txtEmailField.layer.borderWidth         = 1
            txtEmailField.layer.borderColor         = UIColor.purple.cgColor
        }
    }
    @IBOutlet weak var txtPasswordField: UITextField! {
        didSet{
            txtPasswordField.layer.cornerRadius        = txtPasswordField.frame.height / 2
            txtPasswordField.layer.borderWidth         = 1
            txtPasswordField.layer.borderColor         = UIColor.purple.cgColor
        }
    }
    
    @IBOutlet weak var btnRemindMe: UIButton!
    @IBOutlet weak var lblForgotPassword: UILabel!
    
    @IBOutlet weak var btnLogin: UIButton!{
        didSet{
            btnLogin.layer.cornerRadius      = btnLogin.frame.height / 2
        }
    }
    @IBOutlet weak var lblCreateAccount: UITextView!
    @IBOutlet weak var txtViewCreateAccount: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtViewCreateAccount.attributedText = prepareAttributedTextString()
        txtViewCreateAccount.delegate = self
        txtViewCreateAccount.isSelectable = true

    }
    
    func prepareAttributedTextString() -> NSMutableAttributedString {

//            let masterString = "To get more videos in future click me"
            let masterString = "Don't have an account ? Create Accont"

            let formattedString = NSMutableAttributedString(string: masterString)

            let UseAttribute = [
//                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0),
                NSAttributedString.Key.link: URL(string: "Create Accont"),
                
            ] as [NSAttributedString.Key : Any]


            let rangeClick = (masterString as NSString).range(of: "Create Accont")
        
            formattedString.addAttributes(UseAttribute, range: rangeClick)
            
            return formattedString
        }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if (URL.absoluteString == "click me") {
              let objVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InitialVC") as! InitialVC
              self.navigationController?.pushViewController(objVC, animated: true)
         }
         return true
    }
    
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SelectLevelVC") as? SelectLevelVC
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}
