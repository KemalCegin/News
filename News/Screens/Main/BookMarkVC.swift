//
//  BookMarkVC.swift
//  News
//
//  Created by Kemal Cegin on 10.01.2023.
//

import UIKit

class BookMarkVC: UIViewController {
    
    let tableView   = UITableView()
    var articles: [News]  = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewController()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.articles = CoreData.sharedInstance.fetchDataFromCoreData()
        self.tableView.reloadData()
    }
    

    func configureViewController() {
        view.backgroundColor = .systemBackground
        title                = "Bookmarks"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.rowHeight     = 350
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(BookMarkCell.self, forCellReuseIdentifier: BookMarkCell.reuseID)
    }
}

extension BookMarkVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell     = tableView.dequeueReusableCell(withIdentifier: BookMarkCell.reuseID) as! BookMarkCell
        let articles = self.articles[indexPath.row]
        cell.set(articles: articles)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookmark                   = articles[indexPath.row]
        let destVC                     = DescriptionVC()
        destVC.selectedArticle         = bookmark
        destVC.titleLabel.text         = bookmark.title
        destVC.descriptionLabel.text   = bookmark.description
        if let urlToImage              = bookmark.urlToImage {
            destVC.newsImageView.downloadImage(from: urlToImage)
        } else {
            let breakingNewsImage      = UIImage(named: "breakingnews")
            destVC.newsImageView.image = breakingNewsImage
        }
       destVC.dateLabel.text           = bookmark.publishedAt?.convertToDisplayFormat()
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
}
