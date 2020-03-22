//
//  BlockScreen.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 20/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

class BlockScreen: UIView {
    
    // MARK: - API
    func showBlocker(success: @escaping () -> Void) {
        guard let topVC = BlockScreen.topVC else { return }
        topVC.view.addSubview(self)
        alpha = 0
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.alpha = 0.65
            success()
        })
    }
    
    static func hideBlocker() {
        guard let topVC = BlockScreen.topVC else { return }
        for view in topVC.view.subviews where view is BlockScreen {
            view.removeFromSuperview()
        }
    }
    
    // MARK: - Properties
    private let animationDuration = 0.5
    private var infoTxt: String?
    
    private static var topVC: UIViewController? {
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    // MARK: - Inits
    convenience init(title: String?) {
        self.init(frame: UIScreen.main.bounds)
        self.infoTxt = title
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    // MARK: - Helper
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setActivityIndicatorAndInfoLbl(lblTxt: self.infoTxt)
    }
    
    private func setActivityIndicatorAndInfoLbl(lblTxt: String?) {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = center
        addSubview(activityView)
        activityView.startAnimating()
        
        guard let infoTxt = lblTxt else { return }
        let lbl = UILabel()
        lbl.text = infoTxt
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.sizeToFit()
        lbl.center = activityView.center
        lbl.frame.origin.y += 30
        addSubview(lbl)
    }
}
