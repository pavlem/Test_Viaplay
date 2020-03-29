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
    private let collectionViewBackgroundColor = UIColor.gray
    private let sectionsService = SectionsService()
    // MARK: Vars
    private var sectionsItems = [SectionsItemVM]()
    private var sectionCVCHeaderVM: SectionCVCHeaderVM?
    private var dataTask: URLSessionDataTask?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchSections()
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dataTask?.cancel()
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

        self.dataTask = sectionsService.getSections(completion: { [weak self] (sectionResponse, serviceError) in
            guard let `self` = self else { return }
            sleep(1) // to ilustrate loading....
            
            guard serviceError == nil else {
                self.handle(error: serviceError)
                return
            }

            guard let sectionResponse = sectionResponse else { return }
            guard let sections = sectionResponse.links?.viaplaySections else { return }
            
            self.sectionsItems = sections.map({SectionsItemVM(sectionsResponseItem: $0)})
            self.sectionCVCHeaderVM = SectionCVCHeaderVM(sectionsResponse: sectionResponse)
            
            DispatchQueue.main.async {
                BlockScreen.hideBlocker()
                self.collectionView.reloadData()
            }
        })
    }
    
    private func handle(error: ServiceError?) {
        // Here error can be handled somehow, like alert on main thread, etc
        print(error ?? "")
    }
}

// MARK: UICollectionViewDataSource
extension SectionsCVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SectionsCell
        
        
        sectionCell.sectionItemVM = sectionsItems[indexPath.row]
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
        let sectionTVC = UIStoryboard.sectionTVC
        sectionTVC.selectedSection = self.sectionsItems[indexPath.row]
        navigationController?.pushViewController(sectionTVC, animated: true)
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
