//
//  eqWebViewController.swift
//  Earthquakes
//
//  Created by Suhail Ghafoor on 11/13/17.
//  Copyright © 2017 Suhail Ghafoor. All rights reserved.
//

import UIKit
import WebKit

class eqWebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var urlToLoad:String = ""
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        print(urlToLoad)
        loadWebsite()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("loaded website")
        self.spinner.stopAnimating()
    }
    
    //loads the website
    func loadWebsite(){
        let url = URL(string: urlToLoad)
        let request = URLRequest(url: url!)
        webView.navigationDelegate = (self as! WKNavigationDelegate)
        webView.load(request)
    }

}
