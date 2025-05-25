//
//  DetailPresenter.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation
import UIKit
import RxSwift

class DetailPresenter: BasePresenter {
    
    // MARK: Properties
    weak var view: DetailViewController?
    var interactor: DetailInteractor
    var router = DetailRouter()
    
    var movieId: Int = 0
    var movie: Movie?
    
    var reviews: [Review] = []
    var trailer: Video?
    
    init(interactor: DetailInteractor) {
        self.interactor = interactor
    }
    
    func backToPrevious(from navigation: UINavigationController) {
        router.backToPreviousPage(from: navigation)
    }
    
    func getMovieDetail() {
        interactor.getDetailMovie(id: movieId)
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                movie = value
                view?.updateViewData()
            }, onError: { error in
                print(error)
            }) .disposed(by: bag)
    }
    
    func getReviewMovie() {
        interactor.getReviewMovie(id: movieId)
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                reviews = value.results ?? []
                view?.updateReviewData()
            }, onError: { error in
                print(error)
            }) .disposed(by: bag)
    }
    
    func getTrailerMovie() {
        interactor.getVideoMovie(id: movieId)
            .subscribe(onNext: { [weak self] value in
                guard let self = self, let videos = value.results else { return }
                trailer = videos.filter { $0.site == "YouTube" && $0.type == "Trailer" && $0.official == true }.first
                view?.updateTrailerData()
            }, onError: { error in
                print(error)
            }) .disposed(by: bag)
    }
}

