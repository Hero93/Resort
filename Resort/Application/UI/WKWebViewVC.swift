//
//  WKWebViewVC.swift
//  BeResponsible
//
//  Created by Luca LG. Gramaglia on 27/03/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit
import WebKit

enum WebViewLoad {
    case url(URL)
    case localHtml(URL)
}

class WKWebViewVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var wkWebView: WKWebView! {
        didSet {
            wkWebView.backgroundColor = .white
            wkWebView.navigationDelegate = self
        }
    }
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    // MARK: - IVars
    
    //    var url: URL?
    var load: WebViewLoad?
    var navBarTitle: String? {
        didSet {
            self.navigationItem.title = navBarTitle ?? NSLocalizedString("activities.media.navbar.title", comment: "")
        }
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL()
    }
    
    // MARK: - Private methods

    private func loadURL() {
        
        guard let load = load else { return }
        
        switch load {
        case .url(let url):
            
            let urlRequest = URLRequest(url: url)
            wkWebView.load(urlRequest)
            
        case .localHtml(let url):
            
            wkWebView.loadFileURL(url, allowingReadAccessTo: url)
            let request = URLRequest(url: url)
            wkWebView.load(request)
        }
    }
}

// MARK: - WKNavigationDelegate

extension WKWebViewVC : WKNavigationDelegate {
    
    // MARK: Start
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicatorView.startAnimating()
    }
    
    // MARK: Finish
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
    }
    
    // MARK: Failures
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicatorView.stopAnimating()
    }
}
