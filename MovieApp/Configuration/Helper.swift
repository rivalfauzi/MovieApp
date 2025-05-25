//
//  Helper.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Network
import UIKit

let imageCache = NSCache<NSString, UIImage>()

final class Reachability {
    static let shared = Reachability()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private(set) var isConnected: Bool = true
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}

func loadImage(from urlString: String, into imageView: UIImageView) {
    if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
        imageView.image = cachedImage
        return
    }
    
    guard let url = URL(string: urlString) else {
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, let image = UIImage(data: data), error == nil else {
            return
        }
        
        imageCache.setObject(image, forKey: NSString(string: urlString))
        
        DispatchQueue.main.async {
            imageView.image = image
        }
    }.resume()
}

func showNoConnectionAlert() {
    guard let topVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else { return }
    
    var presenter = topVC
    while let presented = presenter.presentedViewController {
        presenter = presented
    }
    
    let alert = UIAlertController(
        title: "No Internet Connection",
        message: "Please check your internet connection and try again.",
        preferredStyle: .alert
    )
    
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    presenter.present(alert, animated: true)
}

