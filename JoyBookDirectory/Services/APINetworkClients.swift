//
//  APINetworkClients.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import Alamofire
import PromiseKit

enum NetworkError: Error {
    case invalidResponse
}

protocol APINetworkManaging {
    func getParamRequest(_ strURL: String, parameters: [String: AnyObject]?, headers: HTTPHeaders?) -> Promise<Any>
}

class APINetworkClient: APINetworkManaging{
    
    static let shared = APINetworkClient()
    
    private func handleResponse(_ response: AFDataResponse<Any>, seal: Resolver<Any>) {
        switch response.result {
        case .success(let value):
            if let json = value as? [String: Any] {
                seal.fulfill(json)
            } else {
                seal.reject(NetworkError.invalidResponse)
            }
        case .failure(let error):
            seal.reject(error)
        }
    }
    
    private func makeRequest(_ strURL: String, method: HTTPMethod, parameters: [String: AnyObject]?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Promise<Any> {
        return Promise { seal in
            AF.request(strURL, method: method, parameters: parameters, encoding: encoding, headers: headers)
                .validate(statusCode: 200 ..< 600)
                .responseJSON { response in
                    print("APINetworkClient -> Make Request Response of \(strURL) -> \(response)")
                    self.handleResponse(response, seal: seal)
                }
        }
    }
    
    func getParamRequest(_ strURL: String, parameters: [String: AnyObject]?, headers: HTTPHeaders?) -> Promise<Any> {
        return makeRequest(strURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
    }
    
}
