//
//  APIDataResponseClient.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import PromiseKit
import ObjectMapper
import SwiftyJSON
import Alamofire

class APIDataResponseClient {
    
    static let shared = APIDataResponseClient()
    
    private let apiNetworkClient: APINetworkManaging
    
    init(apiNetworkClient: APINetworkManaging = APINetworkClient.shared){
        self.apiNetworkClient = apiNetworkClient
    }
    
    private func buildURL(endpoint: String, params: [String: AnyObject]?) -> String {
        var url = Domain.baseUrl() + endpoint
        if let queryParams = params, !queryParams.isEmpty {
            let queryString = queryParams.map { key, value in
                return "\(key)=\(value)"
            }.joined(separator: "&")
            url += "?" + queryString
        }
        return url
    }
    
    private func processJSONResponse<T: Mappable>(json: Any) throws -> T {
        let swiftyJSON = JSON(json)
        guard let dataResponse = Mapper<T>().map(JSON: swiftyJSON.dictionaryObject ?? [:]) else {
            throw NetworkError.invalidResponse
        }
        return dataResponse
    }
    
    func getSuccessResponse<T: Mappable>(endpoint: String, params: [String: AnyObject]? = nil) -> Promise<T> {
        return Promise { seal in
            let url = buildURL(endpoint: endpoint, params: params)
            apiNetworkClient.getParamRequest(url, parameters: nil, headers: APIHeaders.shared.getHeader())
                .done { json in
                    let dataResponse: T = try self.processJSONResponse(json: json)
                    seal.fulfill(dataResponse)
                }
                .catch { error in
                    seal.reject(error)
                }
        }
    }
}
