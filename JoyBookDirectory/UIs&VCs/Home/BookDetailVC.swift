//
//  BookDetailVC.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

class BookDetailVC: BaseVC {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookSubTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    @IBOutlet weak var bookNoOfPages: UILabel!
    @IBOutlet weak var bookPublishedYear: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    
    // MARK: ViewModels
    private let bookDetailViewModel = BookDetailViewModel(apiDataResponseClient: APIDataResponseClient())
    
    // MARK: Variables
    var bookID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        functionalSetup()
    }
    
    private func uiSetup(){
        
    }
    
    private func functionalSetup(){
        fetchBookDetail(bookID: bookID ?? "")
    }
    
    //MARK: API
    /// BookDetail
    private func fetchBookDetail(bookID: String){
        
        let bookDetailEndpoint = "book/" + bookID
        
        bookDetailViewModel.getBookDetail(endpoint: bookDetailEndpoint, completion: { [weak self] (success, message) in
            guard let self = self else { return }
            
            if success{
                self.bookDetailDataEntry(bookDetailData: bookDetailViewModel.bookDetailResponse)
                self.showToastAlert(title: message, message: "", alertStyle: .alert)
            }else{
                self.showToastAlert(title: message, message: "", alertStyle: .alert)
            }
            
        }, loadingHandler: { [weak self] isLoading in
            guard let self = self else { return }
            self.handleLoading(isLoading: isLoading)
        })
    }
    
    //MARK: Book Detail Data Entry
    private func bookDetailDataEntry(bookDetailData: BookDetailResponse?){
        if let imageList = bookDetailData?.image{
            let url = URL(string: imageList)
            bookImage.kf.setImage(with: url)
        }else{
            bookImage.image = UIImage(named: "placeholder")
        }
        bookTitle.text = bookDetailData?.title ?? "-"
        bookSubTitle.text = bookDetailData?.subtitle ?? "-"
        bookAuthor.text = bookDetailData?.authors ?? "-"
        bookPublisher.text = bookDetailData?.publisher ?? "-"
        bookNoOfPages.text = bookDetailData?.pages ?? "-"
        bookPublishedYear.text = bookDetailData?.year ?? "-"
        bookDescription.text = bookDetailData?.description ?? "-"
    }
    
}
