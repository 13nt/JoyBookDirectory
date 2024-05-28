//
//  BookListTableViewCell.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit
import Kingfisher

protocol BookListTableViewCellDelegate: AnyObject{
    func bookDetailBtnTapped(in cell: BookListTableViewCell)
}
                                            
class BookListTableViewCell: UITableViewCell {
    
    weak var delegate: BookListTableViewCellDelegate?
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookSubTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    
    @IBOutlet weak var bgView: RoundedShadowView!
    
    var bookListData: BookListData?{
        didSet{
            showBookListData()
        }
    }
    
    private func showBookListData(){
        if let imageList = bookListData?.image{
            let url = URL(string: imageList)
            bookImage.kf.setImage(with: url)
        }else{
            bookImage.image = UIImage(named: "placeholder")
        }
        
        bookTitle.text = bookListData?.title ?? "-"
        bookSubTitle.text = bookListData?.subtitle ?? "-"
        bookAuthor.text = bookListData?.authors ?? "-"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func bookDetailBtnClicked(_ sender: UIButton){
        delegate?.bookDetailBtnTapped(in: self)
    }
    
}
