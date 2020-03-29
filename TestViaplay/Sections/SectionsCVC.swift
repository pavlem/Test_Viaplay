//
//  SectionCVC.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 19/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class SectionsCVC: UICollectionViewController {
    
    // MARK: - Properties
    // MARK: Constants
    private let reuseIdentifier = "SectionsCell_ID"
    private let blockScrTxt = "Fetching the sections..."
    private let sectionsService = SectionsService()
    private var sections = [SectionsItemVM]()     // TODO: Array of VM instad of sections

    private var sectionCVCHeaderVM: SectionCVCHeaderVM?
    private let collectionViewBackgroundColor = UIColor.gray
    
    // MARK: Vars
    private var dataTask: URLSessionDataTask?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchSections()
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        dataTask?.cancel() // TODO: Fix this
        BlockScreen.hideBlocker()
    }
    
    // MARK: - Helper
    private func setUI() {
        collectionView.backgroundColor = collectionViewBackgroundColor
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Sections".uppercased()
    }
    
    private func fetchSections() {
        BlockScreen().showBlocker(messageText: blockScrTxt) {}

        self.dataTask = sectionsService.getSections(completion: { [weak self] (sectionResponse, serRrr) in
            guard let `self` = self else { return }
            sleep(1) // to ilustrate loading....
            // TODO: Error handling

            guard let sectionResponse = sectionResponse else { return }
            guard let sections = sectionResponse.links?.viaplaySections else { return }
            
            self.sections = sections.map({SectionsItemVM(sectionsResponseItem: $0)})
            self.sectionCVCHeaderVM = SectionCVCHeaderVM(sectionsResponse: sectionResponse)
            
            DispatchQueue.main.async {
                BlockScreen.hideBlocker()
                self.collectionView.reloadData()
            }
        })
    }
}

// MARK: UICollectionViewDataSource
extension SectionsCVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SectionsCell
        
        
        sectionCell.sectionItemVM = sections[indexPath.row]
        return sectionCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartHeaderCollectionReusableView_ID", for: indexPath) as! SectionsCVCHeader
            
            if let sectionCVCHeaderVM = self.sectionCVCHeaderVM {
                headerView.sectionCVCHeaderVM = sectionCVCHeaderVM
            }
            return headerView
        }

        fatalError()
    }
}


// MARK: UICollectionViewDelegate
extension SectionsCVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        BlockScreen().showBlocker(messageText: "Fetching: " + sections[indexPath.row].title) {}
        
        navigationController?.pushViewController(UIStoryboard.sectionTVC, animated: true)

        let selectedSection = self.sections[indexPath.row]

        dataTask = sectionsService.getSection(path: selectedSection.path) { (sectionResponse, serverError) in
            guard serverError == nil else { return } // TODO: Error handling
            guard let sectionResponse = sectionResponse else { return }
            guard let sectionItems = sectionResponse.links?.viaplayCategoryFilters?.map({SectionItemVM(sectionResponseItem: $0)}) else { return }
            self.sectionTVC?.sectionItemsVM = sectionItems
            
            
            // TODO: SectionTVC header
        }
    }
    
    private var sectionTVC: SectionTVC? {
        return navigationController?.viewControllers.last as? SectionTVC
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SectionsCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
           layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width-20)/2
        return CGSize(width: width, height: width)
    }
}
