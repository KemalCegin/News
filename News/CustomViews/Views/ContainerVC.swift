import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    var rootViewController: UIViewController?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        addChildVCs()
        addTapGestureToRootViewController()
        setupRootViewController()
        addSwipeGestureRecognizers()
    }
 
    private func addChildVCs() {
        //Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //Home
        if let rootViewController = rootViewController {
            addChild(rootViewController)
            view.addSubview(rootViewController.view)
            rootViewController.didMove(toParent: self)
        }
        
    }

    
    private func addSwipeGestureRecognizers() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)

    }
    

    private func setupRootViewController() {
        guard let rootViewController = rootViewController else { return }
        addChild(rootViewController)
        view.addSubview(rootViewController.view)
        rootViewController.didMove(toParent: self)
    }

    @objc private func handleSwipeLeft() {
        if menuState == .opened {
            toggleMenu(completion: nil)
        }
    }

    @objc private func handleSwipeRight() {
        if menuState == .closed {
            toggleMenu(completion: nil)
        }
    }
    
    private func addTapGestureToRootViewController() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.cancelsTouchesInView = false
        rootViewController?.view.addGestureRecognizer(tap)
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        if menuState == .opened {
            toggleMenu(completion: nil)
        }
    }


    func toggleMenu(completion: (() -> Void)?) {
        let targetState: MenuState = menuState == .closed ? .opened : .closed
        
        let animateMenu = {
            let menuWidth = self.menuVC.view.frame.width
            let targetPosition = targetState == .opened ? menuWidth - 100 : 0
            self.rootViewController?.view.frame.origin.x = targetPosition
        }
        
        let completionBlock = { [weak self] (done: Bool) in
            if done {
                self?.menuState = targetState
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
        
        UIView.animate(withDuration:  0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: animateMenu, completion: completionBlock)
    }
    
}

extension ContainerViewController: HomeVCDelegate {
    
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
}

extension ContainerViewController: MenuViewControllerDelegate {
    
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        didTapMenuButton()
        toggleMenu {
            switch menuItem {
                
            case .home:
                break
            case .business:
                let businessVC = BusinessVC()
                self.present(UINavigationController(rootViewController: businessVC), animated: true)
            case .sports:
                let sportsVC = SportsVC()
                self.present(UINavigationController(rootViewController: sportsVC), animated: true)
            case .science:
                let scienceVC = ScienceVC()
                self.present(UINavigationController(rootViewController: scienceVC), animated: true )
            case .health:
                let healthVC = HealthVC()
                self.present(UINavigationController(rootViewController: healthVC), animated: true)
            case .technology:
                let technologyVC = TechnologyVC()
                self.present(UINavigationController(rootViewController: technologyVC), animated: true)
            }
        }
    }
    
}
