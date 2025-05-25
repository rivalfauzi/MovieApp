//
//  BaseViewController.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    var bag = DisposeBag()
    let loadingScreen = LoadingScreen()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
