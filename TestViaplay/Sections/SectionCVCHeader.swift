//
//  SectionCVCHeader.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 23/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class SectionCVCHeader: UICollectionReusableView {
    
    // MARK: - Properties
    // MARK: Outlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    // MARK: Vars
    var sectionCVCHeaderVM: SectionCVCHeaderVM? {
        willSet {
            if let value = newValue {
                updateUI(sectionCVCHeaderVM: value)
            }
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setInitialTxt()
        setUI()
    }
    
    // MARK: - Helper
    private func setUI() {
        self.backgroundColor = .gray
        
        self.title.font = UIFont.boldSystemFont(ofSize: 14)
        self.descriptionLbl.font = UIFont.systemFont(ofSize: 14)
        
        self.title.textColor = .white
        self.descriptionLbl.textColor = .white
    }
    
    private func updateUI(sectionCVCHeaderVM: SectionCVCHeaderVM) {
        self.title.text = sectionCVCHeaderVM.title
        self.descriptionLbl.text = sectionCVCHeaderVM.description
    }
    
    private func setInitialTxt() {
        title.text = ""
        descriptionLbl.text = ""
    }
}
