//
//  DetailRouter.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation
import UIKit

class DetailRouter: BaseRouter {
    
    func showView() -> DetailViewController {
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(interactor: interactor)
        let view = DetailViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
}
