//
//  HomeVC.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

class HomeVC: BaseVC {
    
    @IBOutlet weak var topView: TopNavView!
    @IBOutlet weak var bookListTableView: UITableView!{
        didSet{
            bookListTableView.delegate = self
            bookListTableView.dataSource = self
            bookListTableView.registerForCell(strID: BookListTableViewCell.nibName)
        }
    }
    
    // MARK: ViewModels
    private let bookListViewModel = BookListViewModel(apiDataResponseClient: APIDataResponseClient())

    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        functionalSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    private func uiSetup(){
        let username = LocalStorage.shared.getUsername()
        topView.name.text = username
        topView.searchBtn.addTarget(self, action: #selector(toSearchBookVC), for: .touchUpInside)
        topView.logoutBtn.addTarget(self, action: #selector(logOutFunc), for: .touchUpInside)
    }
    
    private func functionalSetup(){
        fetchBookList(endpoint: "recent")
    }
    
    ///LogOut Action
    @objc func logOutFunc(){
        LocalStorage.shared.setIsLoggedIn(false)
//        LocalStorage.shared.logout()
        toLoginInVC()
    }
    
    // MARK: API
    /// Book Lists
    private func fetchBookList(endpoint: String){
        
        bookListViewModel.getBookList(endpoint: endpoint, completion: { [weak self] (success, message) in
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

}

extension HomeVC: UITableViewDataSource{
    
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

extension HomeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.addHapticFeedback(forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension HomeVC: BookListTableViewCellDelegate{
    
    func bookDetailBtnTapped(in cell: BookListTableViewCell) {
        guard let indexPath = bookListTableView.indexPath(for: cell) else {
            return
        }
        toBookDetailVC(bookID: bookListViewModel.bookList[indexPath.row].id)
    }
    
}
