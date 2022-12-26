//
//  WebViewController.swift
//  MarvelTavern
//
//  Created by Paul Matar on 25/12/2022.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKNavigationDelegate {
    
    private lazy var webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(.init(url: url))
    }
}
