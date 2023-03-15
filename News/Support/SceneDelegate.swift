//
//  SceneDelegate.swift
//  News
//
//  Created by Kemal Cegin on 3.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let containerVC = ContainerViewController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let tabBarVC = createTabbar()
        containerVC.rootViewController = tabBarVC
        window?.rootViewController = containerVC
        window?.makeKeyAndVisible()
        configureNavigationBar()
    }
    
    
    func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemBlue
        tabbar.viewControllers = [createHomeNC(),  createBookMarkNC()]
        tabbar.tabBar.backgroundColor = .systemBackground
        
        return tabbar
    }
    
    
    func createHomeNC() -> UINavigationController {
        let homeVC      = HomeVC()
        homeVC.delegate = containerVC
        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        let homeIcon = UIImage(systemName: "house.circle", withConfiguration: iconConfig)
        

        homeVC.tabBarItem = UITabBarItem(title: "Home", image: homeIcon, tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
  
    
    func createBookMarkNC() -> UINavigationController {
        let bookMarkVC = BookMarkVC()
        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        let bookMarkIcon = UIImage(systemName: "book.circle", withConfiguration: iconConfig)
        bookMarkVC.title = "BookMark"
        bookMarkVC.tabBarItem = UITabBarItem(title: "BookMark", image: bookMarkIcon, tag: 1)
        return UINavigationController(rootViewController: bookMarkVC)
        
    }
    
    
    
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemBlue
    }
    
    

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }


}




