//
//  SectionCVC.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 19/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class SectionCVC: UICollectionViewController {
    
    // MARK: - Properties
    // MARK: Constants
    private let reuseIdentifier = "SectionCell_ID"
    private let sectionsService = SectionsService()
    private var sections = [SectionItemVM]()     // TODO: Array of VM instad of sections

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

        BlockScreen(title: "Fetching the sections...").showBlocker(isOverEntireDeviceWindow: false) {}
        
        self.dataTask = sectionsService.getSections(completion: { [weak self] (sectionResponse, serRrr) in
            guard let `self` = self else { return }
            
            // TODO: Error handling
            
            guard let sectionResponse = sectionResponse else { return }
            guard let sections = sectionResponse.links?.viaplaySections else { return }
            
            self.sections = sections.map({SectionItemVM(sectionsResponseItem: $0)})
            self.sectionCVCHeaderVM = SectionCVCHeaderVM(sectionsResponse: sectionResponse)
            
            sleep(2)
            DispatchQueue.main.async {
                BlockScreen.hideBlocker()
                self.collectionView.reloadData()
            }
        })
    }
}

// MARK: UICollectionViewDataSource
extension SectionCVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SectionCell
        
        
        sectionCell.sectionItemVM = sections[indexPath.row]
        return sectionCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartHeaderCollectionReusableView_ID", for: indexPath) as! SectionCVCHeader
            
            if let sectionCVCHeaderVM = self.sectionCVCHeaderVM {
                headerView.sectionCVCHeaderVM = sectionCVCHeaderVM
            }
            return headerView
        }

        fatalError()
    }
}


// MARK: UICollectionViewDelegate
extension SectionCVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
        let sec = self.sections[indexPath.row]
        print(sec.url)
        
//        https://content.viaplay.se/ios-se/sport2
        
        sectionsService.getSection(path: "/sport2") { (secR, serErr) in
            
            print("ssss")
        }
        
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SectionCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
           layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width-20)/2
        return CGSize(width: width, height: width)
    }
}
