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
    var selectedSection: SectionsItemVM?
    
    // MARK: - Properties
    // MARK: Constants
    private let sectionsService = SectionsService()
    // MARK: Vars
    private var dataTask: URLSessionDataTask?
    // MARK: Calculated
    private var sectionItemsVM = [SectionItemVM]() {
        willSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                BlockScreen.hideBlocker()
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        fetchSectionItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BlockScreen().showBlocker(messageText: "Fetching: " + selectedSection!.title) {}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dataTask?.cancel()
        BlockScreen.hideBlocker()
    }

    // MARK: - Helper
    private func fetchSectionItems() {
        dataTask = sectionsService.getSection(path: selectedSection!.path) { (sectionResponse, serverError) in
            sleep(2) // Simulate slower data fetch

            guard serverError == nil else {
                self.handle(error: serverError)
                return
            }
            
            guard let sectionResponse = sectionResponse else { return }
            guard let sectionItems = sectionResponse.links?.viaplayCategoryFilters?.map({SectionItemVM(sectionResponseItem: $0)}) else { return }
            self.sectionItemsVM = sectionItems

            // TODO: SectionTVC header
        }
    }
    
    private func setUI() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func handle(error: ServiceError?) {
        print(error ?? "")
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
