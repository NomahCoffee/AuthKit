//
//  SignupView.swift
//  AuthKit
//
//  Created by Caleb Rudnicki on 7/7/21.
//

import UIKit
import SnapKit
import NCUtils

protocol SignupViewDelegate: MembershipViewDelegate {
    /// Tigger a signup action
    /// - Parameters:
    ///   - email: a `String` for the user's email
    ///   - username: a `String` for the user's username
    ///   - firstName: a `String` for the user's first name
    ///   - lastName: a `String` for the user's last name
    ///   - password: a `String` for the user's password
    ///   - repassword: a `String` for the user's re-entered password
    func signup(email: String, username: String, firstName: String,
                lastName: String, password: String, repassword: String)
}

class SignupView: UIView {
    
    var delegate: SignupViewDelegate?
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = MembershipConstants.Signup.headerTitle
        titleLabel.font = Fonts.Oxygen.header1
        titleLabel.textColor = UIColor(rgb: 0xF0F5F9)
        return titleLabel
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = MembershipConstants.Signup.headerSubtitle
        subtitleLabel.font = Fonts.Oxygen.body2
        subtitleLabel.textColor = UIColor(rgb: 0xECF3F9)
        return subtitleLabel
    }()
    
    private let emailTextField: NCEmailTextField = {
        let emailTextField = NCEmailTextField()
        emailTextField.placeholder = MembershipConstants.Signup.emailTextFieldPlaceholder
        emailTextField.backgroundColor = UIColor(rgb: 0xD1B99B)
        emailTextField.textColor = .label
        emailTextField.font = Fonts.Oxygen.title6
        emailTextField.layer.cornerRadius = 16
        emailTextField.layer.borderWidth = 0
        return emailTextField
    }()
    
    private let usernameTextField: NCTextField = {
        let usernameTextField = NCTextField()
        usernameTextField.autocapitalizationType = .none
        usernameTextField.placeholder = MembershipConstants.Signup.usernameTextFieldPlaceholder
        usernameTextField.backgroundColor = UIColor(rgb: 0xD1B99B)
        usernameTextField.textColor = .label
        usernameTextField.font = Fonts.Oxygen.title6
        usernameTextField.layer.cornerRadius = 16
        usernameTextField.layer.borderWidth = 0
        return usernameTextField
    }()
    
    private let firstNameTextField: NCTextField = {
        let firstNameTextField = NCTextField()
        firstNameTextField.placeholder = MembershipConstants.Signup.firstNameTextFieldPlaceholder
        firstNameTextField.backgroundColor = UIColor(rgb: 0xD1B99B)
        firstNameTextField.textColor = .label
        firstNameTextField.font = Fonts.Oxygen.title6
        firstNameTextField.layer.cornerRadius = 16
        firstNameTextField.layer.borderWidth = 0
        return firstNameTextField
    }()
    
    private let lastNameTextField: NCTextField = {
        let lastNameTextField = NCTextField()
        lastNameTextField.placeholder = MembershipConstants.Signup.lastNameTextFieldPlaceholder
        lastNameTextField.backgroundColor = UIColor(rgb: 0xD1B99B)
        lastNameTextField.textColor = .label
        lastNameTextField.font = Fonts.Oxygen.title6
        lastNameTextField.layer.cornerRadius = 16
        lastNameTextField.layer.borderWidth = 0
        return lastNameTextField
    }()
    
    private let passwordTextField: NCPasswordTextField = {
        let passwordTextField = NCPasswordTextField()
        passwordTextField.placeholder = MembershipConstants.Signup.passwordTextFieldPlaceholder
        passwordTextField.backgroundColor = UIColor(rgb: 0xD1B99B)
        passwordTextField.textColor = .label
        passwordTextField.font = Fonts.Oxygen.title6
        passwordTextField.layer.cornerRadius = 16
        passwordTextField.layer.borderWidth = 0
        return passwordTextField
    }()
    
    private let repasswordTextField: NCPasswordTextField = {
        let repasswordTextField = NCPasswordTextField()
        repasswordTextField.placeholder = MembershipConstants.Signup.repasswordTextFieldPlaceholder
        repasswordTextField.backgroundColor = UIColor(rgb: 0xD1B99B)
        repasswordTextField.textColor = .label
        repasswordTextField.font = Fonts.Oxygen.title6
        repasswordTextField.layer.cornerRadius = 16
        repasswordTextField.layer.borderWidth = 0
        return repasswordTextField
    }()
    
    private let goToLoginLabel: UILabel = {
        let goToLoginLabel = UILabel()
        goToLoginLabel.text = "Already have an account?"
        goToLoginLabel.textColor = UIColor(rgb: 0xECF3F9)
        goToLoginLabel.font = Fonts.Oxygen.subtitle2
        return goToLoginLabel
    }()
    
    private let goToLoginButton: UIButton = {
        let goToLoginButton = UIButton()
        goToLoginButton.setTitle(MembershipConstants.Signup.toggleButtonTitle, for: .normal)
        goToLoginButton.setTitleColor(UIColor(rgb: 0x9BBFD1), for: .normal)
        goToLoginButton.addTarget(self, action: #selector(goToLoginButtonTapped), for: .touchUpInside)
        goToLoginButton.titleLabel?.font = Fonts.Oxygen.subtitle2
        return goToLoginButton
    }()
    
    private let goToLoginStack: UIStackView = {
        let goToLoginStack = UIStackView()
        goToLoginStack.axis = .horizontal
        goToLoginStack.spacing = 4
        return goToLoginStack
    }()
    
    private let signupButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle(MembershipConstants.Signup.submitButtonTitle, for: .normal)
        loginButton.setTitleColor(UIColor(rgb: 0xECF3F9), for: .normal)
        loginButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        loginButton.titleLabel?.font = Fonts.Oxygen.button1
        loginButton.backgroundColor = UIColor(rgb: 0x487185)
        loginButton.layer.cornerRadius = 16
        return loginButton
    }()
    
    private let stackContainer = UIView()
    
    private let nameStack: UIStackView = {
        let nameStack = UIStackView()
        nameStack.axis = .horizontal
        nameStack.distribution = .fillEqually
        nameStack.spacing = MembershipConstants.stackSpacing
        return nameStack
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = MembershipConstants.stackSpacing
        return stack
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(usernameTextField)
        nameStack.addArrangedSubviews([firstNameTextField, lastNameTextField])
        stack.addArrangedSubview(nameStack)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(repasswordTextField)

        stackContainer.addSubview(stack)
        
        goToLoginStack.addArrangedSubviews([goToLoginLabel, goToLoginButton])
        
        addSubviews([titleLabel, subtitleLabel])
        addSubview(stackContainer)
        addSubview(signupButton)
        addSubview(goToLoginStack)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(32)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        stackContainer.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(signupButton.snp.top)
        }
        
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(MembershipConstants.submitButtonHeight)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(MembershipConstants.submitButtonHeight)
        }
        
        firstNameTextField.snp.makeConstraints { make in
            make.height.equalTo(MembershipConstants.submitButtonHeight)
        }
        
        lastNameTextField.snp.makeConstraints { make in
            make.height.equalTo(MembershipConstants.submitButtonHeight)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(MembershipConstants.submitButtonHeight)
        }
        
        repasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(MembershipConstants.submitButtonHeight)
        }
        
        signupButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(MembershipConstants.submitButtonHeight)
        }
        
        goToLoginStack.snp.makeConstraints { make in
            make.top.equalTo(signupButton.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin).inset(32)
        }
        
        goToLoginStack.isHidden = AuthKitManager.shared.membershipOption == .signupOnly ? true : false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc private func signupButtonTapped() {
        if emailTextField.isFulfilled,
           usernameTextField.isFulfilled,
           firstNameTextField.isFulfilled,
           lastNameTextField.isFulfilled,
           passwordTextField.isFulfilled,
           repasswordTextField.isFulfilled,
           let email = emailTextField.text,
           let username = usernameTextField.text,
           let firstName = firstNameTextField.text,
           let lastName = lastNameTextField.text,
           let password = passwordTextField.text,
           let repassword = repasswordTextField.text {
            delegate?.signup(email: email,
                             username: username,
                             firstName: firstName,
                             lastName: lastName,
                             password: password,
                             repassword: repassword)
           }
    }
    
    @objc private func goToLoginButtonTapped() {
        delegate?.toggleMembershipView(toShowLogin: true)
    }

}
