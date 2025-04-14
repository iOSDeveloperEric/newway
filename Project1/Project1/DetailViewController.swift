//
//  DetailViewController.swift
//  Project1
//
//  Created by Raj Patel on 14/04/25.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    var selectedImage : String?
    var imageIndex: Int = 0
    var totalImageCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "selectedImage \(imageIndex) of \(totalImageCount)"
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
