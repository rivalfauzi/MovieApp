//
//  DashboardPresenter.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation
import UIKit
import RxSwift

class DashboardPresenter: BasePresenter {
    
    // MARK: Properties
    weak var view: DashboardViewController?
    var interactor: DashboardInteractor
    var router = DashboardRouter()
    var movies: [Movie] = []
    var coverMovie: Movie?
    
    private var currentPage = 0
    private var isLoading = false
    
    init(interactor: DashboardInteractor) {
        self.interactor = interactor
    }
    
    func fetchMovieData(page: Int) {
        guard !isLoading else { return }
        isLoading = true
        
        interactor.getListMovie(page: page)
            .subscribe(onNext: { [weak self] value in
                guard let self = self, let listMovie = value.results else { return }
                if self.currentPage == 1, let first = listMovie.first {
                    self.coverMovie = first
                    self.movies = Array(listMovie.dropFirst())
                } else {
                    self.movies.append(contentsOf: listMovie)
                }
                
                self.view?.showSkeletonAndLoadData()
                self.isLoading = false
            }, onError: { [weak self] _ in
                self?.isLoading = false
            }) .disposed(by: bag)
    }
    
    func loadNextPageIfNeeded() {
        currentPage += 1
        fetchMovieData(page: currentPage)
    }

}

