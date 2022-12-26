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
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
        
    private lazy var progressSymbol: UIImageView = {
        let frame = CGRect(x: 0, y: 0, width: 37, height: 33)
        let iv = UIImageView(frame: frame)
        let image = UIImage(systemName: "aqi.medium",
                            variableValue: progressValue)
        iv.image = image
        return iv
    }()
    
    private var progressValue = 0.0 {
        didSet {
            progressSymbol.image = UIImage(systemName: "aqi.medium",
                                           variableValue: progressValue)
        }
    }

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
        initialize()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "estimatedProgress" else { return }
        progressSymbol.isHidden = webView.estimatedProgress == 1.0
        progressValue = webView.estimatedProgress
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    private func initialize() {
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new,
                            context: nil)
        let progressButton = UIBarButtonItem(customView: progressSymbol)
        navigationItem.rightBarButtonItem = progressButton
        webView.load(.init(url: url))
    }
}
