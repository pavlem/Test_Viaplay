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
    private let sectionsCellId = "SectionsCell_ID"
    private let sectionsHeaderId = "CartHeaderCollectionReusableView_ID"
    private let blockScrTxt = "Fetching the sections..."
    private let collectionViewBackgroundColor = UIColor.gray
    private let sectionsService = SectionsService()
    // MARK: Vars
    private var sectionsItems = [SectionsItemVM]()
    private var sectionCVCHeaderVM: SectionsCVCHeaderVM?
    private var dataTask: URLSessionDataTask?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchLocalOrRemoteSections()
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
    
    private func fetchLocalOrRemoteSections() {
        if FetchTimeoutHelper.shared.isSectionsFetchNeeded {
            fetchSections()
        } else {
            fetchLocalSections()
        }
    }
    
    private func fetchLocalSections(errorReceived: ServiceError? = nil) {
        self.fetchLocalSections(withName: ServiceEndpoint.ios) { (sectionsResponse) in
            guard let sectionResponse = sectionsResponse else {
                if let err = errorReceived {
                    ErrorHandler.handle(error: err, vc: self)
                }
                return
            }
            self.handle(sectionsResponse: sectionResponse)
        }
    }
    
    private func fetchSections() {
        BlockScreen().showBlocker(messageText: blockScrTxt) {}

        self.dataTask = sectionsService.getSections(completion: { [weak self] (sectionsResponse, serviceError) in
            guard let `self` = self else { return }
           
            if let serviceError = serviceError {
                switch serviceError {
                case .noInternetConnection:
                    self.fetchLocalSections(errorReceived: serviceError)
                default:
                    ErrorHandler.handle(error: serviceError, vc: self)
                }
                return
            }
            
            sleep(1) // to ilustrate loading....
            guard let sectionResponse = sectionsResponse else { return }
            self.handle(sectionsResponse: sectionResponse)
        })
    }
    
    private func handle(sectionsResponse: SectionsResponse) {
        guard let sections = sectionsResponse.links?.viaplaySections else { return }
        self.sectionsItems = sections.map({SectionsItemVM(sectionsResponseItem: $0)})
        self.sectionCVCHeaderVM = SectionsCVCHeaderVM(sectionsResponse: sectionsResponse)
        
        DispatchQueue.main.async {
            BlockScreen.hideBlocker()
            self.collectionView.reloadData()
        }
    }
    
    private func fetchLocalSections(withName jsonName: String, completion: (SectionsResponse?) -> ()) {
        
        guard let jsonLocal = try? JSONSerialization.loadJSON(withFilename: jsonName), let dataLocal = try? JSONSerialization.data(withJSONObject: jsonLocal, options: .prettyPrinted) else {
            completion(nil)
            return
        }
        
        let sectionsResponse = try? JSONDecoder().decode(SectionsResponse.self, from: dataLocal)
        completion(sectionsResponse)
    }
}

// MARK: UICollectionViewDataSource
extension SectionsCVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: sectionsCellId, for: indexPath) as! SectionsCell
        
        
        sectionCell.sectionItemVM = sectionsItems[indexPath.row]
        return sectionCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionsHeaderId, for: indexPath) as! SectionsCVCHeader
            
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
