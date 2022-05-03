//
//  MainViewController.swift
//  ListMovies5
//
//  Created by Bryan Andres  Almeida Flores on 03/05/2022.
//


import UIKit
class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let username = UserDefaults.standard.string(forKey: Constants.username) {
            print("WelcomeAgain \(username)")
            presentHome()
        } else{
            print("No")
            presentLogin()
        }
    }
    
    func presentHome() {
        let home = PrincipalViewController()
        
        let nav = UINavigationController(rootViewController: home)
        nav.modalPresentationStyle = .fullScreen
        nav.view.backgroundColor = .white
        self.present(nav, animated: true)
        
        
    }
    func presentLogin() {
        let login = LoginViewController()
        let nav = UINavigationController(rootViewController: login)
        nav.modalPresentationStyle = .fullScreen
        nav.view.backgroundColor = .white
        self.present(nav, animated: true)
    }
    
    
    
    
    
}

