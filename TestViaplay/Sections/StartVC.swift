//
//  StartVC.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 19/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class StartVC: UIViewController {
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUI()
        initializeFetchDataTimeoutHelper()
    }
    
    private func initializeFetchDataTimeoutHelper() {
        let _ = FetchTimeoutHelper.shared
    }
    
    // MARK: - Helper
    private func setUI() {
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Actions
    @IBAction func start(_ sender: UIButton) {
        navigationController?.pushViewController(UIStoryboard.sectionsCVC, animated: true)
    }
}
