//
//  ViewController.swift
//  AuthKitExample
//
//  Created by Caleb Rudnicki on 7/9/21.
//

import UIKit
import AuthKit
import SnapKit

class ViewController: UIViewController {
    
    let logoutButtonNoChange: UIButton = {
        let logoutButtonNoChange = UIButton()
        logoutButtonNoChange.setTitle("Logout (existing AuthKit options)", for: .normal)
        logoutButtonNoChange.setTitleColor(.label, for: .normal)
        logoutButtonNoChange.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return logoutButtonNoChange
    }()
    
    let logoutButtonBothLoginAndLogout: UIButton = {
        let logoutButtonBothLoginAndLogout = UIButton()
        logoutButtonBothLoginAndLogout.setTitle("Logout (show login and signup)", for: .normal)
        logoutButtonBothLoginAndLogout.setTitleColor(.label, for: .normal)
        logoutButtonBothLoginAndLogout.addTarget(self, action: #selector(logoutButtonBothLoginAndLogoutTapped), for: .touchUpInside)
        return logoutButtonBothLoginAndLogout
    }()
    
    let logoutButtonToLoginOnly: UIButton = {
        let logoutButtonToLoginOnly = UIButton()
        logoutButtonToLoginOnly.setTitle("Logout (show login only)", for: .normal)
        logoutButtonToLoginOnly.setTitleColor(.label, for: .normal)
        logoutButtonToLoginOnly.addTarget(self, action: #selector(logoutButtonToLoginOnlyTapped), for: .touchUpInside)
        return logoutButtonToLoginOnly
    }()
    
    let logoutButtonToSignupOnly: UIButton = {
        let logoutButtonToSignupOnly = UIButton()
        logoutButtonToSignupOnly.setTitle("Logout (show signup only)", for: .normal)
        logoutButtonToSignupOnly.setTitleColor(.label, for: .normal)
        logoutButtonToSignupOnly.addTarget(self, action: #selector(logoutButtonToSignupOnlyTapped), for: .touchUpInside)
        logoutButtonToSignupOnly.titleLabel?.font = Fonts.Oxygen.button1
        return logoutButtonToSignupOnly
    }()
    
    let printCurrentUserButton: UIButton = {
        let printCurrentUserButton = UIButton()
        printCurrentUserButton.setTitle("Print Current User", for: .normal)
        printCurrentUserButton.setTitleColor(.label, for: .normal)
        printCurrentUserButton.addTarget(self, action: #selector(printCurrentUserButtonTapped), for: .touchUpInside)
        return printCurrentUserButton
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(stack)
        
        stack.addArrangedSubviews(
            [logoutButtonNoChange, logoutButtonBothLoginAndLogout, logoutButtonToLoginOnly,
             logoutButtonToSignupOnly, printCurrentUserButton]
        )
        
        stack.snp.makeConstraints { make in
            make.edges.centerY.equalToSuperview()
        }
    }
    
    @objc private func logoutButtonTapped() {
        AuthKitManager.shared.logout(from: self)
    }
    
    @objc private func logoutButtonBothLoginAndLogoutTapped() {
        AuthKitManager.shared.membershipOption = .loginAndSignup
        AuthKitManager.shared.logout(from: self)
    }
    
    @objc private func logoutButtonToLoginOnlyTapped() {
        AuthKitManager.shared.membershipOption = .loginOnly
        AuthKitManager.shared.logout(from: self)
    }
    
    @objc private func logoutButtonToSignupOnlyTapped() {
        AuthKitManager.shared.membershipOption = .signupOnly
        AuthKitManager.shared.logout(from: self)
    }
    
    @objc private func printCurrentUserButtonTapped() {
        if let user = AuthKitManager.shared.currentUser as? ExampleUser {
            print("Current user: \(user.firstName) \(user.lastName)")
        }
    }

}

