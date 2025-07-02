//
//  ViewController.swift
//  Project7
//
//  Created by Raj Patel on 08/05/25.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlStringApi()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View", style: .plain, target: self, action: #selector(openTapped))
    }
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "This is Site", message: "Open that size", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(ac, animated: true)
    }

    func urlStringApi(){
        let urlString : String
       if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        

        // Please switch to an asynchronous networking API such as URLSession.
//        if let url = URL(string: urlString){
//            if let data = try? Data(contentsOf: url){
//                parse(json: data)
//            }
//        }
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    self.parse(json: data)
                } else {
                    self.showError()
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
            task.resume()
        }else {
            self.showError()
        }

    }
    
    func showError(){
        let ac = UIAlertController(title: "Data Loading", message: "There is error for loading message, Please try new", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }

    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            DispatchQueue.main.async {
                self.petitions = jsonPetitions.results
                self.tableView.reloadData()
            }
        }else{
            print("Its not normal")
        }
    
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

