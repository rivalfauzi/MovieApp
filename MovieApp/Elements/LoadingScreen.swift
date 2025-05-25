//
//  LoadingScreen.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//


import Foundation
import UIKit

class LoadingScreen: UIView {
    static let shared = LoadingScreen()

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupNotifications()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupNotifications()
    }
    
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(showLoading), name: .requestDidStart, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideLoading), name: .requestDidFinish, object: nil)
    }

    @objc private func showLoading() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow {
                self.frame = window.bounds
                window.addSubview(self)
            }
        }
    }

    @objc private func hideLoading() {
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
