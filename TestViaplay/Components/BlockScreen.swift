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
    func showBlocker(isOverEntireDeviceWindow: Bool = false, messageText: String? = nil, messageFont: UIFont = UIFont.systemFont(ofSize: 17), backgroundColor: UIColor = .black, success: @escaping () -> Void) {
        guard let topVC = BlockScreen.topVC else { return }
    
        frame = UIScreen.main.bounds
        setActivityIndicatorAndInfoLbl(messageText: messageText,
                                       messageFont: messageFont,
                                       backgroundColor: backgroundColor)
        
        if isOverEntireDeviceWindow, let nc = topVC as? UINavigationController {
            if nc.navigationBar.layer.zPosition == 0 {
                nc.navigationBar.layer.zPosition = -1
            }
        }
        
        if let nc = topVC as? UINavigationController {
            frame.origin.y = nc.navigationBar.frame.height + statusBarFrameHeight
        }
        
        topVC.view.addSubview(self)
        alpha = 0
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.alpha = 0.6
            success()
        })
    }
    
    static func hideBlocker() {
        guard let topVC = BlockScreen.topVC else { return }
        
        if let nc = topVC as? UINavigationController {
            if nc.navigationBar.layer.zPosition == -1 {
                nc.navigationBar.layer.zPosition = 0
            }
        }
        
        for view in topVC.view.subviews where view is BlockScreen {
            view.removeFromSuperview()
        }
    }
    
    // MARK: - Properties
    private let animationDuration = 0.5
    
    private static var topVC: UIViewController? {
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    private var statusBarFrameHeight: CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarFrameHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return statusBarFrameHeight
    }
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Helper
    private func setActivityIndicatorAndInfoLbl(messageText: String?, messageFont: UIFont, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        
        setActivityIndicatorView()
        setMsgLbl(txt: messageText, txtFont: messageFont)
    }
    
    private func setActivityIndicatorView() {
        let animatingView = UIActivityIndicatorView(style: .large)
        animatingView.color = .white
        animatingView.translatesAutoresizingMaskIntoConstraints = false

        if let nc = BlockScreen.topVC as? UINavigationController {
            animatingView.frame.origin.y -= nc.navigationBar.frame.height + statusBarFrameHeight
        }
        
        addSubview(animatingView)
        animatingView.startAnimating()
        // Constraints
        animatingView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        animatingView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setMsgLbl(txt: String?, txtFont: UIFont) {
        let lbl = UILabel()
        lbl.text = txt
        lbl.textColor = .white
        lbl.font = txtFont
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lbl)
        // Constraints
        lbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lbl.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50).isActive = true
        lbl.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
    }
}
