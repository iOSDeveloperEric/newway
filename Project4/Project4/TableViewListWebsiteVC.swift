//
//  TableViewListWebsiteVC.swift
//  Project4
//
//  Created by Raj Patel on 05/05/25.
//

import UIKit

class TableViewListWebsiteVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var websiteArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
}

extension TableViewListWebsiteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websiteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell") as! WebsiteCell
        cell.textLabel?.text = websiteArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newVC = WebView()
        newVC.websites = websiteArray[indexPath.row]
        navigationController?.pushViewController(newVC, animated: true)
    }
}
