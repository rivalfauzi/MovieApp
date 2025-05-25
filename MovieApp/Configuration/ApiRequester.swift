//
//  ApiRequester.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation
import RxSwift
import Alamofire

class ApiRequest {
    static let shared = ApiRequest()
    
    func request(_ endpoint: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders?, completion: @escaping (_ responseJson: AFDataResponse<Any>) -> Void) {
        if !Reachability.shared.isConnected {
            let error = AFError.sessionInvalidated(error: URLError(.notConnectedToInternet))
            let errorResponse = errorResponse(error)
            
            DispatchQueue.main.async {
                showNoConnectionAlert()
            }
            
            completion(errorResponse)
            return
        }
        
        NotificationCenter.default.post(name: .requestDidStart, object: nil)
        
        guard let url = URL(string: endpoint) else {
            let errorResponse = errorResponse(AFError.invalidURL(url: endpoint))
            completion(errorResponse)
            return
        }
        
        var allHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        allHeaders.add(name: "Authorization", value: TOKEN)
        
        if let headers = headers {
            for header in headers {
                allHeaders.update(header) 
            }
        }
        
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: allHeaders).responseJSON { response in
            NotificationCenter.default.post(name: .requestDidFinish, object: nil)
            completion(response)
        }
    }
    
    private func errorResponse(_ error: AFError) -> AFDataResponse<Any> {
        return AFDataResponse<Any>(
            request: nil,
            response: nil,
            data: nil,
            metrics: nil,
            serializationDuration: 0,
            result: .failure(error)
        )
    }
}
