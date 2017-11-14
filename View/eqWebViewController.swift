//
//  eqWebViewController.swift
//  Earthquakes
//
//  Created by Suhail Ghafoor on 11/13/17.
//  Copyright © 2017 Suhail Ghafoor. All rights reserved.
//

import UIKit
import WebKit

class eqWebViewController: UIViewController {
    
    var urlToLoad:String = ""
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(urlToLoad)
        loadWebsite()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadWebsite(){
        let url = URL(string: urlToLoad)
        let request = URLRequest(url: url!)
        webView.load(request)
    }

}
