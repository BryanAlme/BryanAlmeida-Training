//
//  LoginView.swift
//  ListMovies5
//
//  Created by Bryan Andres  Almeida Flores on 03/05/2022.
//


import UIKit

class LoginViewController: UIViewController {
    
    
    private lazy var usernameField: UITextField = {
        let usernameField = UITextField()
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        usernameField.placeholder = "Enter your name"
        usernameField.borderStyle = .roundedRect
        usernameField.layer.cornerRadius = 8
        return usernameField
    }()
    
    
    private lazy var saveButton : UIButton = {
        let saveButton : UIButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle(" !!!! Press Me !!!!", for: .normal)
        saveButton.backgroundColor = .black
        saveButton.layer.cornerRadius = 15
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        return saveButton
    }()

    @objc private func save(sender:UIButton) {
        if let username = usernameField.text{
            if username .isEmpty{
                showAlert(for: self, message: "More than 3 Characters, Please")
                return
            }
            UserDefaults.standard.set(username, forKey: Constants.username)
            self.dismiss(animated: true)
        }
    }
    
    private func showAlert(for controller: UIViewController, message: String) {
        let alert =  UIAlertController(title: "Atention!!", message: "More than 3 Characters, Please", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        view.addSubview(usernameField)
        view.addSubview(saveButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
        usernameField.topAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -480).isActive = true
        usernameField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        usernameField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        
        
        saveButton.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        
    }
}
