//
//  TopNavView.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

protocol TopNavViewDelegate: AnyObject {
    
}

class TopNavView: UIView{
    
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var name: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let bundle = Bundle.init(for: TopNavView.self)
        if let viewToAdd = bundle.loadNibNamed(TopNavView.nibName, owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    func loadFromNib (nibName: String) -> UIView {
        let nib = UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: TopNavView.self).first as! UIView
        return view
    }
}
