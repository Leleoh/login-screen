//
//  TabBarController.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 06/05/25.
//
import UIKit

class TabBarController: UITabBarController{
    
    lazy var tasksTabBar: UINavigationController = {
        let title = "Tasks"
        let image = UIImage(systemName: "list.bullet.rectangle.portrait")
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: image)
        let rootViewController = TasksViewController()
        rootViewController.tabBarItem = tabItem
        

        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }()
    
    lazy var profileTabBar: UINavigationController = {
        let title = "Profile"
        let image = UIImage(systemName: "person.circle.fill")
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: image)
        let rootViewController = ProfileViewController()
        rootViewController.tabBarItem = tabItem
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [tasksTabBar, profileTabBar]
    }
    

}//Fim da classe
