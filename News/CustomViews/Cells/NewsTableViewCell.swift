//
//  NewsTableViewCell.swift
//  News
//
//  Created by Kemal Cegin on 4.01.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    static let reuseID  = "FavoriteCell"
    let newsImageView   = NewsImageView(frame: .zero)
    let newsTitlelabel  = NewsTitleLabel(textAlignment: .left, fontSize: 16)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func set(articles: News) {
        newsTitlelabel.text = articles.title
        if let imageUrl = articles.urlToImage {
            newsImageView.downloadImage(from: imageUrl)
        } else {
            let breakingNewsImage      = UIImage(named: "breakingnews")
            newsImageView.image = breakingNewsImage
        }
            
            }
    
    
    private func configure() {
        addSubview(newsImageView)
        addSubview(newsTitlelabel)
        
        accessoryType        = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            newsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            newsImageView.heightAnchor.constraint(equalToConstant: 200),

            newsTitlelabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            newsTitlelabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            newsTitlelabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            newsTitlelabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }
    
}
/*NSLayoutConstraint.activate([
 
 newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
 newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
 newsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
 newsImageView.heightAnchor.constraint(equalToConstant: 200),
 
 newsTitlelabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
 newsTitlelabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
 newsTitlelabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -16),
 newsTitlelabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
 
])*/
