//
//  LoginViewController.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var viewModelLogin: ViewModelLogin = ViewModelLogin()
    var uiLogin: UILogin = UILogin()
    var loader: UIAlertController = UIAlertController()
    var isShowingKeybord: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor(colorIdentifier: .background)
        uiLogin.delegate = self
        uiLogin.textFieldUsername.delegate = self
        uiLogin.textFieldPassword.delegate = self
        uiLogin.setLayoutConstraint(view: self.view)

        registerKeyboardAppearenceObserver()
    }
    
    private func registerKeyboardAppearenceObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            if (self.view.frame.origin.y == 0) {
                self.view.frame.origin.y -= keyboardSize.height / 3
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func configView() {
        Task {
            self.loader = self.loader(message: UIConstants.Loader.Loader_mensage)
            self.present(self.loader, animated: true, completion: nil)
            try await self.viewModelLogin.getDataLogin(loader: loader,
                                             username: self.uiLogin.textFieldUsername.text ?? String(),
                                             password: self.uiLogin.textFieldPassword.text ?? String()) { (result, error) in
                Task {
                    self.uiLogin.lblError.text = error
                }
                if result {
                    DispatchQueue.main.async {
                        self.loader.dismiss(animated: true) {
                            guard let dashVC = DashboardRouter.createModuleOfLogin() else { return }
                            dashVC.view.backgroundColor = UIColor(colorIdentifier: .background)
                            self.navigationController?.pushViewController(dashVC, animated: true)
                        }
                    }
                }
            }
        }
    }
    
}

extension LoginViewController: delegateUILogin {
    func actionLogin() {
        configView()
    }
}
