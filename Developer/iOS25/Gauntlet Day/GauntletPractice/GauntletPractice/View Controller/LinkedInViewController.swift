//
//  LinkedInViewController.swift
//  GauntletPractice
//
//  Created by Colin Smith on 4/14/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit
import WebKit
class LinkedInViewController: UIViewController,WKUIDelegate {

    @IBOutlet weak var linkedInWebView: WKWebView!
    
    var profile: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let profile = profile else {return}
        let webConfiguration = WKWebViewConfiguration()
        linkedInWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        linkedInWebView.uiDelegate = self
        view = linkedInWebView
        guard let homeURL = URL(string: profile) else {return}
            let homeRequest = URLRequest(url: homeURL)
        linkedInWebView.load(homeRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
