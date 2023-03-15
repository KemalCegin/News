import UIKit

protocol BusinessVCDelegate: AnyObject {
    func didTapMenuButton()
}

class BusinessVC: UIViewController {
    
    // MARK: - Properties
    
    var delegate: BusinessVCDelegate?
    var articles: [News] = []
    
    enum Section {
        case main
    }
    
  
    private let tableview = UITableView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIBar()
        configureTableView()
        getArticles(for: .business)
    }
    
    // MARK: - UI Configuration
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    func configureUIBar() {
        view.backgroundColor = .systemBackground
        title = "Business"
        navigationController?.navigationBar.prefersLargeTitles = true
         
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = closeButton
       
    }
    
    // MARK: - Actions
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
   
    
    // MARK: - TableView Configuration
    
    func configureTableView() {
        view.addSubview(tableview)
        tableview.frame = view.bounds
        tableview.rowHeight = 350
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorColor = UIColor.black
        layoutTableView()
        
        tableview.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
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
    
   

    
    // MARK: - API Call
    
    func getArticles(for category: NewsCategory) {
        NetworkManager.shared.getArticles(for: category.rawValue) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                self.articles = articles
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - TableView Delegate and DataSource



extension BusinessVC: UITableViewDataSource, UITableViewDelegate {
    
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

