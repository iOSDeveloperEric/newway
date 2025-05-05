//
//  ViewController.swift
//  Project4
//
//  Created by Raj Patel on 17/04/25.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @objc var webView: WKWebView!
    let containerView = UIView()
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingithswift", "facebook.com"]
    
    override func loadView() {
        containerView.backgroundColor = .lightGray
        
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        webView.navigationDelegate = self
        self.view = containerView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "TableView", style: .plain, target: self, action: #selector(openTableView))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(title: "Forward", style: .done, target: self, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressBar = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [backButton, progressBar, spacer, refresh, forwardButton]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }


    @objc func openTableView(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "TableViewListWebsiteVC") as! TableViewListWebsiteVC
        vc.websiteArray = websites
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)

        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac, animated: true)
    }
    
    func canOpenURL(_ string: String?) -> Bool {
        guard let urlString = string,
            let url = URL(string: urlString)
            else { return false }

        if !UIApplication.shared.canOpenURL(url) { return false }

        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    func openPage(action: UIAlertAction){
        guard let actionTitle = action.title else {return}
        var checkUrl = "https://" + actionTitle
        if canOpenURL(checkUrl) {
            print("valid url.")
            guard let url = URL(string: checkUrl) else {return}
            webView.load(URLRequest(url: url))
        } else {
            print("invalid url.") // This line executes
            showInvalidWebsiteAlert()

        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
        
    }
    
    func showInvalidWebsiteAlert() {
        let alert = UIAlertController(title: "Blocked",
                                      message: "This website is not allowed.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        // Present the alert on the main thread
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

