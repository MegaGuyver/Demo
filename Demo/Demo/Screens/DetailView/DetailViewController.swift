//
//  DetailViewController.swift
//  Demo
//
//  Created by khawaja fahad on 30/12/2023.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var urlString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = URL (string: urlString) {
           let requestObj = URLRequest(url: url)
           self.webView.load(requestObj)
       }
        
    }
}


