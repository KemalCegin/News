//
//  DescriptionVC.swift
//  News
//
//  Created by Kemal Cegin on 7.01.2023.
//

import UIKit
import CoreData

class DescriptionVC: UIViewController {
    
    var selectedArticle: News!
    
    let newsImageView    = NewsImageView(frame: .zero)
    let titleLabel       = NewsTitleLabel(textAlignment: .left, fontSize: 20)
    let descriptionLabel = NewsDescriptionTitleLabel(fontSize: 16)
    let dateLabel        = NewsDateLabel(textAlignment: .left)
    
    let scrollView               = UIScrollView()
    let stackView                = UIStackView()
    let descriptionContainerView = UIView()
    let bookMarkContainerView    = UIView()
    let bookmarkButton: UIButton = {
    let button                   = UIButton(type: .system)
        button.tintColor         = .black
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
     }()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        checkBookMark()
       
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }


    func configureViewController() {
        view.backgroundColor = .systemBackground
        //performBack()
        configureScrollView()
        configureContentView()
    }
    

    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints  = false

            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    
    func configureContentView() {
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(newsImageView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionContainerView)
     
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        scrollView.addSubview(stackView)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionContainerView.addSubview(descriptionLabel)
        descriptionContainerView.addSubview(bookmarkButton)
        NSLayoutConstraint.activate([
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContainerView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionContainerView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionContainerView.trailingAnchor, constant: -16),
            
            bookmarkButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 44),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 44),
            bookmarkButton.trailingAnchor.constraint(equalTo: descriptionContainerView.trailingAnchor, constant: -40),
            descriptionContainerView.heightAnchor.constraint(equalToConstant: textHeight(text: descriptionLabel.text ?? "") + 44 + 16)
        ])
       
        let padding: CGFloat = 16
        let leadingConstraint = stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        let trailingConstraint = stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        let topConstraint = stackView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        let witdh = stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        
        NSLayoutConstraint.activate([
            
            leadingConstraint,
            trailingConstraint,
            topConstraint,
            bottomConstraint,
            witdh,
            
            newsImageView.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    
    @objc func buttonTapped() {
        let isSaved = CoreData.sharedInstance.isSaved(news: self.selectedArticle)
        if let image = self.bookmarkButton.image(for: .normal), image == UIImage(systemName: "bookmark") {
            if !isSaved {
                CoreData.sharedInstance.saveData(news: self.selectedArticle)
                self.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            } else {
                print("Article already saved.")
            }
        } else {
            CoreData.sharedInstance.deleteSelectedArticle(news: self.selectedArticle)
            self.bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            
        }
    }
    
    
    func textHeight(text: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 18)
        let width = view.frame.width - 20 // 20 pixels of padding on both sides

        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        return text.boundingRect(with: textSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
    }

    
    private func checkBookMark() {
        let isSaved = CoreData.sharedInstance.isSaved(news: self.selectedArticle)

        if isSaved {
            self.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            self.bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
}


