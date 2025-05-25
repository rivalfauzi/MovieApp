//
//  UpcomingInteractor.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation
import RxSwift
import Alamofire

class UpcomingInteractor: BaseInteractor {
    public func getListMovie(page: Int) -> Observable<MovieResponse> {
        let listMovie = PublishSubject<MovieResponse>()
        let url = MovieURL.upcoming.url() + "?page=\(page)"
        
        ApiRequest.shared.request(url, method: .get, headers: nil) { response in
            guard case .success = response.result,
                  let data = response.data,
                  let res = try? JSONDecoder().decode(MovieResponse.self, from: data)
            else {
                let error = NSError(domain: "com.yourapp.network", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch or decode movie"])
                listMovie.onError(error)
                return
            }
            
            listMovie.onNext(res)
        }
        
        return listMovie
    }
}
