//
//  NewsTitleLabel.swift
//  News
//
//  Created by Kemal Cegin on 4.01.2023.
//

import UIKit

class NewsTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    
    private func configure() {
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        numberOfLines               = 0
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor             = .systemBackground
        sizeToFit()
    }

}
