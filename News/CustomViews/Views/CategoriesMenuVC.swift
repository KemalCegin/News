
import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOptions)
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: MenuViewControllerDelegate?
    
    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case business = "Business"
        case sports = "Sports"
        case science = "Science"
        case health = "Health"
        case technology = "Technology"
        
        var imageName: String {
            switch self {
                
            case .home:
                return "house"
            case .business:
                return "case.fill"
            case .sports:
                return "camera.filters"
            case .science:
                return "atom"
            case .health:
                return "heart.circle.fill"
            case .technology:
                return "network"
            }
        }
    }
    
    private lazy var headerView: UIView = {
          let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
          view.backgroundColor = greyColor
          
          let label = UILabel()
          label.text = "Categories"
          label.textColor = .white
          label.font = UIFont.boldSystemFont(ofSize: 20)
          view.addSubview(label)
          
          let symbol = UIImageView(image: UIImage(systemName: "list.bullet"))
          symbol.tintColor = .white
          view.addSubview(symbol)
          
          label.translatesAutoresizingMaskIntoConstraints = false
          symbol.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              symbol.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              symbol.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
              
              label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              label.leadingAnchor.constraint(equalTo: symbol.trailingAnchor, constant: 16),
          ])
          
          return view
      }()
      
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let greyColor = UIColor(red: 32/255.0, green: 32/255.0, blue: 32/255.0, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        
        view.backgroundColor = greyColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = greyColor
        cell.contentView.backgroundColor = greyColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let separatorView = UIView(frame: CGRect(x: 0, y: cell.contentView.frame.size.height - 1, width: UIScreen.main.bounds.size.width, height: 6))
        separatorView.backgroundColor = greyColor
        cell.contentView.addSubview(separatorView)
    }

}
