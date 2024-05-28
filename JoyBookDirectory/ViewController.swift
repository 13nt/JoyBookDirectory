//
//  ViewController.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 27/05/2024.
//

import UIKit

class ViewController: BaseVC {
    
    private let bookListViewModel = BookListViewModel(apiDataResponseClient: APIDataResponseClient())

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBookList(search: "python")
    }
    
    // MARK: API
    /// Book Lists
    private func fetchBookList(search: String){
        
        bookListViewModel.getBookList(endpoint: search, completion: { [weak self] (success, message) in
            guard let self = self else { return }
            
            if success{
                self.showToastAlert(title: message, message: "", alertStyle: .alert)
            }else{
                self.showToastAlert(title: message, message: "", alertStyle: .alert)
            }
            
        }, loadingHandler: { [weak self] isLoading in
            guard let self = self else { return }
            self.handleLoading(isLoading: isLoading)
        })
    }
    
}

