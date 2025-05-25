//
//  DashboardInteractor.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation
import RxSwift
import Alamofire

class DashboardInteractor: BaseInteractor {
    public func getListMovie(page: Int) -> Observable<MovieResponse> {
        let listMovie = PublishSubject<MovieResponse>()
        let url = MovieURL.gettrendinglist.url() + "?page=\(page)"
        
        ApiRequest.shared.request(url, method: .get, headers: nil) { response in
            switch response.result {
            case .success(let json):
                if let value = response.data {
                    do {
                        let res = try JSONDecoder().decode(MovieResponse.self, from: value)
                        listMovie.onNext(res)
                    } catch let jsonErr {
                        print("error serializing json:", jsonErr)
                    }
                } else {
                    print("error get sof")
                }
            case .failure(let error):
                print("Request failed with error:", error)
            }
        }
        
        return listMovie
    }
}
