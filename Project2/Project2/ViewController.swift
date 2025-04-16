//
//  ViewController.swift
//  Project2
//
//  Created by Raj Patel on 12/04/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var currectAnswer = 0
    var questionAsk = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        countries.append("US")
//        countries.append("UK")
//        countries.append("estonia")
//        countries.append("france")
//        countries.append("germany")
//        countries.append("ireland")
//        countries.append("italy")
//        countries.append("monaco")
//        countries.append("nigeria")
//        countries.append("poland")
//        countries.append("russia")
//        countries.append("spain")
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        askQuestion()
    }

    
    func askQuestion (action: UIAlertAction! = nil){
        countries.shuffle()
        currectAnswer = Int.random(in: 0...2)
        questionAsk += 1
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[currectAnswer].uppercased()), Your Score: \(score)"
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        if questionAsk < 11 {
            if sender.tag == currectAnswer {
                title = "Currect"
                score += 1
            }else {
                title = "Wrong"
                score -= 1
                var wrongAnswer = sender.tag
                
                let ac = UIAlertController(title: "Wrong", message: " You have selected \(countries[wrongAnswer])", preferredStyle: .alert)
                
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                
                present(ac, animated: true)
                
            }
            
            let ac = UIAlertController(title: title, message: "Your scroe is \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        }else {
            
            let ac = UIAlertController(title: "Ten quastion done", message: "Your scroe is \(score)", preferredStyle: .actionSheet)
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
            questionAsk = 0
            score = 0
        }
    }
    
}

