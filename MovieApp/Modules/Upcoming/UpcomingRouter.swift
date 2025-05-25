//
//  UpcomingRouter.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation
import UIKit

class UpcomingRouter: BaseRouter {
    
    func showView() -> UpcomingViewController {
        let interactor = UpcomingInteractor()
        let presenter = UpcomingPresenter(interactor: interactor)
        let view = UpcomingViewController(presenter: presenter)
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
