//
//  SearchBookVC.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

class SearchBookVC: BaseVC {
    
    @IBOutlet weak var searchView: SearchView!{
        didSet{
            searchView.delegate = self
        }
    }
    
    @IBOutlet weak var bookListTableView: UITableView!{
        didSet{
            bookListTableView.delegate = self
            bookListTableView.dataSource = self
            bookListTableView.registerForCell(strID: BookListTableViewCell.nibName)
        }
    }
    
    private let bookListViewModel = BookListViewModel(apiDataResponseClient: APIDataResponseClient())

    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        functionalSetup()
        // Do any additional setup after loading the view.
    }
    
    private func uiSetup(){
        searchView.configuraView(title: "Search by Category(eg: Python)")
        searchView.searchTF.becomeFirstResponder()
    }
    
    private func functionalSetup(){
        fetchSearchBookList(searchCategory: "python")
    }
    
    // MARK: API
    /// Book Lists
    private func fetchSearchBookList(searchCategory: String){
        
        let searchEndpoint = "search/" + searchCategory
        
        bookListViewModel.getBookList(endpoint: searchEndpoint, completion: { [weak self] (success, message) in
            guard let self = self else { return }
            
            if success{
                self.bookListTableView.reloadData()
                self.showToastAlert(title: message, message: "", alertStyle: .alert)
            }else{
                self.showToastAlert(title: message, message: "", alertStyle: .alert)
            }
            
        }, loadingHandler: { [weak self] isLoading in
            guard let self = self else { return }
            self.handleLoading(isLoading: isLoading)
        })
    }
    
    func performSearch() {
        if let searchText = searchView.searchTF.text {
            fetchSearchBookList(searchCategory: searchText)
        }
    }

}

extension SearchBookVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookListViewModel.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookListTableViewCell.identifier, for: indexPath) as! BookListTableViewCell
        
        cell.delegate = self
        cell.bookListData = bookListViewModel.bookList[indexPath.row]
        
        return cell
    }
    
}

extension SearchBookVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.addHapticFeedback(forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension SearchBookVC: BookListTableViewCellDelegate{
    
    func bookDetailBtnTapped(in cell: BookListTableViewCell) {
        guard let indexPath = bookListTableView.indexPath(for: cell) else {
            return
        }
        toBookDetailVC(bookID: bookListViewModel.bookList[indexPath.row].id)
    }
    
}

extension SearchBookVC: SearchViewDelegate {
    func searchView(_ searchView: SearchView, textFieldDidBecomeEmpty searchText: String?) {
        performSearch()
    }
    
    func searchView(_ searchView: SearchView, didPerformSearch searchText: String?) {
        performSearch()
    }
}
