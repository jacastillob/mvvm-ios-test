//
//  HeadlineDetailViewController.swift
//  MVVMMedibankTest
//
//  Created by Jonathan Castillo on 17/8/21.
//
import WebKit
import UIKit

class HeadlineDetailViewController: UIViewController {
        
    @IBOutlet weak var webView: WKWebView!
    var urlHeadline: String!
    
        override func viewDidLoad() {
                super.viewDidLoad()
                webView.navigationDelegate = self
                self.loadURL()
            }
         func loadURL(){
            
            
            guard let headlineUrl:URL = URL(string: urlHeadline ?? "https://www.google.com/") else {
               return
           }
            let urlRequest = URLRequest(url: headlineUrl)
            webView.load(urlRequest)
           
        }
}

extension HeadlineDetailViewController: WKNavigationDelegate {
    
    // 1. Decides whether to allow or cancel a navigation.
    public func webView(_ webView: WKWebView,
                        decidePolicyFor navigationAction: WKNavigationAction,
                        decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        print("navigationAction load:\(String(describing: navigationAction.request.url))")
        decisionHandler(.allow)
    }
    
    // 2. Start loading web address
    func webView(_ webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start load:\(String(describing: webView.url))")
    }
    
    // 3. Fail while loading with an error
    func webView(_ webView: WKWebView,
                 didFail navigation: WKNavigation!,
                 withError error: Error) {
        print("fail with error: \(error.localizedDescription)")
    }
    
    // 4. WKWebView finish loading
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish loading")
    }
}
    
    

