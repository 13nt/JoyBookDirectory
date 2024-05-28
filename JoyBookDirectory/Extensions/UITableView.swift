//
//  UITableView.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

public extension UITableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func registerForCell(strID: String) {
        
        register(UINib(nibName: strID, bundle: nil), forCellReuseIdentifier: strID)
    }
    
    func registerForHeaderFooterView(strID: String) {
        register(UINib(nibName: strID, bundle: nil), forHeaderFooterViewReuseIdentifier: strID)
    }
    
    func addHapticFeedback(forRowAt indexPath: IndexPath) {
        guard let cell = cellForRow(at: indexPath) else { return }
        cell.addHapticFeedback()
    }
    
}
