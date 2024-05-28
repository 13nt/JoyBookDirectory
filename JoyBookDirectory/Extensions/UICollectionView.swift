//
//  UICollectionView.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

public extension UICollectionView {
    
    func registerForCell(strID: String) {
        register(UINib(nibName: strID, bundle: nil), forCellWithReuseIdentifier: strID)
    }
    
    func registerForHeaderView(strID: String) {
        register(UINib(nibName: strID, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: strID)
    }
    
    func registerForFooterView(strID: String) {
        register(UINib(nibName: strID, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: strID)
    }
}
