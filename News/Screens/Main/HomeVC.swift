//
//  HomeVC.swift
//  News
//
//  Created by Kemal Cegin on 3.01.2023.
//
import UIKit

protocol HomeVCDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeVC: UIViewController {
    
    var delegate: HomeVCDelegate?
    enum Section { case main }
    
  
    let tableview                 = UITableView()
    var articles: [News]          = []
  

  

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIBar()
        configureTableView()
        getArticles()
        
    }
    

    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
     func configureUIBar() {
         view.backgroundColor = .systemBackground
         //setupNavigationBar()
         title = "News"
         navigationController?.navigationBar.prefersLargeTitles = true
        
         
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuButton))
    }
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
    

    
    func configureTableView() {
        view.addSubview(tableview)
        tableview.frame           = view.bounds
        tableview.rowHeight       = 350
        tableview.delegate        = self
        tableview.dataSource      = self
        tableview.separatorColor  = UIColor.black
        layoutTableView()
        
        tableview.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
        
        // UIRefreshControl ekleyin
         let refreshControl = UIRefreshControl()
         refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
         tableview.refreshControl = refreshControl
    }
    
    
    @objc func refreshTable() {
        // Yeni verileri almak için NetworkManager'dan verileri yenileyin
        getArticles()
    }
    
    
    func layoutTableView() {
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
        
    
    func getArticles() {
        NetworkManager.shared.getArticles { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let articles):
                self.articles = articles
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    self.tableview.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.tableview.refreshControl?.endRefreshing()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row]
        let destVC = DescriptionVC()
        destVC.selectedArticle = selectedArticle
        if let urlToImage = selectedArticle.urlToImage {
            destVC.newsImageView.downloadImage(from: urlToImage)
        } else {
            let breakingNewsImage = UIImage(named: "breakingnews")
            destVC.newsImageView.image = breakingNewsImage
        }
        destVC.titleLabel.text = selectedArticle.title
        destVC.descriptionLabel.text = selectedArticle.description
        destVC.dateLabel.text = selectedArticle.publishedAt?.convertToDisplayFormat()
        navigationController?.pushViewController(destVC, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let separatorView = UIView(frame: CGRect(x: 0, y: cell.contentView.frame.size.height - 1, width: UIScreen.main.bounds.size.width, height: 4))
        separatorView.backgroundColor = .black
        cell.contentView.addSubview(separatorView)
    }
}


extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID) as! NewsTableViewCell
        let article = articles[indexPath.row]
        cell.set(articles: article)
        return cell
    }
    
  
}

