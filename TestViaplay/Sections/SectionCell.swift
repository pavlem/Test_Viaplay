//
//  SectionCell.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 29/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class SectionCell: UITableViewCell {
    
    // MARK: - API
    var sectionItemVM: SectionItemVM? {
        willSet {
            updateUI(sectionItemVM: newValue)
        }
    }
    
    // MARK: - Properties
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    // MARK: - Helper
    private func updateUI(sectionItemVM: SectionItemVM?) {
        titleLbl.text = sectionItemVM?.title
        typeLbl.text = sectionItemVM?.type
    }
    
    private func setUI() {
        titleLbl.font = UIFont.boldSystemFont(ofSize: 17)
        typeLbl.font = UIFont.systemFont(ofSize: 17)
        titleLbl.textColor = .white
        typeLbl.textColor = .white
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .lightGray
        self.selectedBackgroundView = selectedBackgroundView
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .darkGray
        self.backgroundView = backgroundView
    }
}
