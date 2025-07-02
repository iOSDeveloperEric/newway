//
//  ViewController.swift
//  Project6b
//
//  Created by Raj Patel on 06/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "There"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .red
        label2.text = "Are"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .red
        label3.text = "Some"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .red
        label4.text = "Awesome"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .red
        label5.text = "Labels"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        var previous : UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.16).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }
            
            previous = label
//
//            label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive
            
        }
        
        //        let viewsDictionary = ["label1": label1,
        //                               "label2": label2,
        //                               "label3": label3,
        //                               "label4": label4,
        //                               "label5": label5]
        //
        //        for label in viewsDictionary.keys {
        //            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
        //
        //        }
        //
        //        let matrics = ["labelHeight": 54]
        //        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(==54)-[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: matrics, views: viewsDictionary))
        //
        //    }
        
    }
    
}
