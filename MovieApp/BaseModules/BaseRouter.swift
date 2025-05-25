//
//  BaseRouter.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation
import UIKit

class BaseRouter: NSObject {
    
    func backToPreviousPage(from navigation: UINavigationController) {
        navigation.popViewController(animated: true)
    }
    
}
