//
//  SectionTVC.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 29/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class SectionTVC: UITableViewController {
    
    // MARK: - API
    var sectionItemsVM = [SectionItemVM]() {
        willSet {
            
            sleep(1) // Simulation
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    // MARK: - Helper
    private func setUI() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - UITableViewDataSource
extension SectionTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionItemsVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionCell = tableView.dequeueReusableCell(withIdentifier: "SectionCell_ID", for: indexPath) as! SectionCell
        sectionCell.sectionItemVM = sectionItemsVM[indexPath.row]
        return sectionCell
    }
}

// MARK: - UITableViewDelegate
extension SectionTVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
