//
//  DetailViewController.swift
//  Project1
//
//  Created by Raj Patel on 14/04/25.
//
// MARK: - Project 3 : Social Media :-
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))
        
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
    
    
    @objc func sharedTapped(){
        
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No Image Data")
            return
        }
        
        let imageName = selectedImage
        
        let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        //iPad
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
}
