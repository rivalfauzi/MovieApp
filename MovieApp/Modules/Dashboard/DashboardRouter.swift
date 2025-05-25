//
//  DashboardRouter.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation
import UIKit

class DashboardRouter: BaseRouter {
    
    func showView() -> DashboardViewController {
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter(interactor: interactor)
        let view = DashboardViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func navigateToDetail(from navigation: UINavigationController, movieID: Int) {
        let view = DetailRouter().showView()
        view.presenter.movieId = movieID
        view.hidesBottomBarWhenPushed = true
        
        navigation.pushViewController(view, animated: true)
    }
    
}
