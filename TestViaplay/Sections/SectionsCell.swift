//
//  SectionCell.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 19/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class SectionsCell: UICollectionViewCell {
    
    // MARK: - API
    var sectionItemVM: SectionItemVM? {
        willSet {
            guard let newValue = newValue else { return }
            setUI(newValue: newValue)
        }
    }
    
    // MARK: - Properties
    @IBOutlet weak var sectionName: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    // MARK: - Helper
    private func setUI(newValue: SectionItemVM) {
        sectionName.text = newValue.title
    }
    
    private func setUI() {
        backgroundColor = .darkGray
        sectionName.textColor = .white
        sectionName.font = UIFont.boldSystemFont(ofSize: 15)
    }
}
