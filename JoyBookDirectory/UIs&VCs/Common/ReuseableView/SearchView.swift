//
//  SearchView.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func searchView(_ searchView: SearchView, didPerformSearch searchText: String?)
    func searchView(_ searchView: SearchView, textFieldDidBecomeEmpty searchText: String?)
}

@IBDesignable
final class SearchView: UIView{
    
    @IBOutlet weak var searchTF: SearchTextField!{
        didSet{
            searchTF.delegate = self
        }
    }
    weak var delegate: SearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configuraView(title: String? = ""){
        self.searchTF.placeholder = title
    }
    
    func commonInit(){
        let bundle = Bundle.init(for: SearchView.self)
        if let viewToAdd = bundle.loadNibNamed(SearchView.nibName, owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    func loadFromNib (nibName: String) -> UIView {
        let nib = UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: SearchView.self).first as! UIView
        return view
    }
}

extension SearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.searchView(self, didPerformSearch: (textField.text as String?))
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
//        delegate?.searchView(self, didPerformSearch: textField.text)
        if textField.text?.isEmpty ?? true {
            delegate?.searchView(self, textFieldDidBecomeEmpty: (textField.text as String?))
            textField.resignFirstResponder()
        }
    }
}
