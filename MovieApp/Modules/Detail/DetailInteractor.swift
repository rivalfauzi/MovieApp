//
//  DetailInteractor.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation
import RxSwift
import Alamofire

class DetailInteractor: BaseInteractor {
    func getDetailMovie(id: Int) -> Observable<Movie> {
        let movie = PublishSubject<Movie>()
        let url = MovieURL.detail.url(id)
        
        ApiRequest.shared.request(url, method: .get, headers: nil) { response in
            guard case .success = response.result, let data = response.data, let res = try? JSONDecoder().decode(Movie.self, from: data) else {
                let error = NSError(domain: "com.yourapp.network", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch or decode movie"])
                movie.onError(error)
                return
            }
            
            movie.onNext(res)
        }
        
        return movie
    }
    
    func getReviewMovie(id: Int) -> Observable<ResponseReview> {
        let responseReview = PublishSubject<ResponseReview>()
        let url = MovieURL.review.url(id)
        
        ApiRequest.shared.request(url, method: .get, headers: nil) { response in
            guard case .success = response.result, let data = response.data, let res = try? JSONDecoder().decode(ResponseReview.self, from: data) else {
                let error = NSError(domain: "com.yourapp.network", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch or decode movie"])
                responseReview.onError(error)
                return
            }
            
            responseReview.onNext(res)
        }
        
        return responseReview
    }
    
    func getVideoMovie(id: Int) -> Observable<VideoResponse> {
        let responseVideo = PublishSubject<VideoResponse>()
        let url = MovieURL.video.url(id)
        
        ApiRequest.shared.request(url, method: .get, headers: nil) { response in
            guard case .success = response.result, let data = response.data, let res = try? JSONDecoder().decode(VideoResponse.self, from: data) else {
                let error = NSError(domain: "com.yourapp.network", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch or decode movie"])
                responseVideo.onError(error)
                return
            }
            
            responseVideo.onNext(res)
        }
        
        return responseVideo
    }
}
