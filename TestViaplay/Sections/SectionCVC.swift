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
    // MARK: Outlets
 
    // MARK: Coinstants
    private let reuseIdentifier = "SectionCell_ID"
    private let sectionsService = SectionsService()
    private var sections = [SectionsResponseItem]()     // TODO: Array of VM instad of sections

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
        navigationController?.isNavigationBarHidden = false
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Sections".uppercased()
    }
    
    private func fetchSections() {
        
        BlockScreen(title: "Fetching the sections...").showBlocker {}
        
        self.dataTask = sectionsService.getSection(completion: { [weak self] (sectionResponse, serRrr) in
            guard let `self` = self else { return }
            
            guard let sections = sectionResponse?.links?.viaplaySections else { return }
            self.sections = sections
            
            sleep(1) // This is for a simulation purpose only...
            
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
        sectionCell.sectionName.text = sections[indexPath.row].title
        sectionCell.backgroundColor = .orange
        return sectionCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
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
