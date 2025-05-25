//
//  YouTubePlayerView.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//


import WebKit

class YouTubePlayerView: UIView {
    private var webView: WKWebView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWebView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupWebView()
    }

    private func setupWebView() {
        webView = WKWebView(frame: self.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(webView)
    }

    func loadVideo(withKey key: String) {
        let urlString = "https://www.youtube.com/embed/\(key)?playsinline=1"
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
}
