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
    // MARK: Outlets
    @IBOutlet weak var sectionHeader: UIView!
    @IBOutlet weak var sectionTitleLbl: UILabel!
    @IBOutlet weak var sectionDescriptionLbl: UILabel!
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
    
    private var sectionHeaderVM: SectionHeaderVM? {
        willSet {
            setHeader(sectionHeaderVM: newValue)
        }
    }
    
    private func setHeader(sectionHeaderVM: SectionHeaderVM?) {
        DispatchQueue.main.async {
            self.sectionTitleLbl.text = sectionHeaderVM?.title
            self.sectionDescriptionLbl.text = sectionHeaderVM?.description
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
            self.sectionHeaderVM = SectionHeaderVM(sectionResponse: sectionResponse)
        }
    }
    
    private func setUI() {
        navigationItem.title = selectedSection?.title.uppercased()
        sectionTitleLbl.text = ""
        sectionDescriptionLbl.text = ""
        
        sectionTitleLbl.textColor = .white
        sectionDescriptionLbl.textColor = .white
        sectionHeader.backgroundColor = .gray
        tableView.backgroundColor = .gray
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = .white
    }
    
    private func handle(error: ServiceError?) {
        // Here error can be handled somehow, like alert on main thread, etc
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
