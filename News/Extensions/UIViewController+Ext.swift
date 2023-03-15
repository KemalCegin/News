//
//  UIViewController+Ext.swift
//  News
//
//  Created by Kemal Cegin on 9.01.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func performBack() {
        let image = UIImage(systemName: "arrow.uturn.left")
        let tintedImage = image?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)

        let button                    = UIButton(type: .system)
        
        button.titleLabel?.font       = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.setImage(tintedImage, for: .normal)
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

        let backButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = backButton
    }
    
    
    @objc func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
}
