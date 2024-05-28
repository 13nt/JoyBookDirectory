//
//  BookListViewModel.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import Foundation
import PromiseKit

class BookListViewModel{
    private let apiDataResponseClient: APIDataResponseClient
    
    init(apiDataResponseClient: APIDataResponseClient) {
        self.apiDataResponseClient = apiDataResponseClient
    }
    
    var bookListResponse: BookListResponse?
    
    // MARK: Book List
    var bookList: [BookListData] = []
    
    func getBookList(endpoint: String, completion: @escaping (Bool, String?) -> Void, loadingHandler: @escaping (Bool) -> Void){
        
        loadingHandler(true)
        
        apiDataResponseClient.getSuccessResponse(endpoint: endpoint)
            .done { [weak self] (response: BookListResponse) in
                guard let self = self else { return }
                self.bookListResponse = response
                self.bookList = response.bookListData ?? []
                if response.status == "ok" {
                    completion(true, "Data fetched successfully.")
                } else {
                    completion(false, "Data \(response.status ?? "Not Found!")")
                }
            }
            .catch { error in
                print("Failed Fetching \(endpoint) Data: \(error)")
                completion(false, "An error occurred during fetching book list data.")
            }
            .finally {
                loadingHandler(false)
            }
  
    }
}
