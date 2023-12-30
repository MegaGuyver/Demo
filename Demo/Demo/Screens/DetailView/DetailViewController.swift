//
//  DetailViewController.swift
//  Demo
//
//  Created by khawaja fahad on 30/12/2023.
//

import UIKit
import WebKit
import SwiftLoader

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var urlString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        // Do any additional setup after loading the view.
        SwiftLoader.show(title: "Fetching...", animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = URL (string: urlString) {
           let requestObj = URLRequest(url: url)
           self.webView.load(requestObj)
       }
        
    }
    
    func webView(_ webView: WKWebView, didFinish  navigation: WKNavigation!)
    {
        SwiftLoader.hide()
    }
}


