//
//  ViewController.swift
//  Project5
//
//  Created by Raj Patel on 05/05/25.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWord = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWord = try? String(contentsOf: startWordURL) {
                allWords = startWord.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }

    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        let submitAnswer = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAnswer)
        present(ac, animated: true)
    }
    
    
    
    func startGame(){
        title = allWords.randomElement()
        usedWord.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    func submit(_ answer: String){
        
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWord.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }else {
                    errorTitle = "Word Not Recognise"
                    errorMessage = "You can't just make them up, "
                }
            }else {
                errorTitle = "Word is already used"
                errorMessage = "be More original"
            }
        }else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word \(title?.lowercased())"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            }else {
                return false
            }
        }
        return true
    }
    
    
    func isOriginal(word: String) -> Bool {
        return !usedWord.contains(word)
    }
    
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        
        return misspelledRange.location == NSNotFound
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWord.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWord[indexPath.row]
        return cell
    }
}

