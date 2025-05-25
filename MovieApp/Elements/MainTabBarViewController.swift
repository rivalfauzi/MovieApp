//
//  MainTabBarViewController.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension MainTabBarViewController {
    private func setupView() {
        let dashboardViewController = UINavigationController(rootViewController: DashboardRouter().showView())
        let upcomingViewController = UINavigationController(rootViewController: UpcomingRouter().showView())
        let topSearchViewColntroller = UINavigationController(rootViewController: TopSearchViewController())
        let downloadScreenViewController = UINavigationController(rootViewController: DownloadScreenViewController())
        
        dashboardViewController.tabBarItem.image = UIImage(systemName: "house")
        upcomingViewController.tabBarItem.image = UIImage(systemName: "play.circle")
        topSearchViewColntroller.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadScreenViewController.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        dashboardViewController.title = "general.dashboard".localized
        upcomingViewController.title = "general.upcoming".localized
        topSearchViewColntroller.title = "general.top_search".localized
        downloadScreenViewController.title = "general.download".localized
        
        tabBar.tintColor = .label
        
        self.setViewControllers([dashboardViewController, upcomingViewController, topSearchViewColntroller, downloadScreenViewController], animated: true)
    }
}

