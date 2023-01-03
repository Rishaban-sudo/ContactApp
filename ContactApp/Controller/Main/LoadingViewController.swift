//
//  LoadingViewController.swift
//  ContactApp
//
//  Created by rishab-13586 on 03/01/23.
//

import Foundation
import UIKit

final class LoadingViewController: UIViewController {

    private static let shared = LoadingViewController()
    
    public static func getInstance() -> LoadingViewController {
        return shared
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
            
            indicator.style = .medium
            indicator.color = .white
            
            indicator.startAnimating()
            
            indicator.autoresizingMask = [
                .flexibleLeftMargin, .flexibleRightMargin,
                .flexibleTopMargin, .flexibleBottomMargin
            ]
                
            return indicator
    }()
    
//    var blurEffectView: UIVisualEffectView = {
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//
//        blurEffectView.alpha = 0.8
//
//        blurEffectView.autoresizingMask = [
//            .flexibleWidth, .flexibleHeight
//        ]
//
//        return blurEffectView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0x808080, alpha: 0.5)
        
//        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
//        blurEffectView.frame = self.view.bounds
//        view.insertSubview(blurEffectView, at: 0)
        
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        view.addSubview(loadingActivityIndicator)
    }


}
