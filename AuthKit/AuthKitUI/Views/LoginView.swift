//
//  LoginView.swift
//  AuthKit
//
//  Created by Caleb Rudnicki on 7/7/21.
//

import UIKit
import SnapKit
import NCUtils

protocol LoginViewDelegate: MembershipViewDelegate {
    /// Trigger a login action
    /// - Parameters:
    ///   - email: a `String` for the user's email
    ///   - password: a `String` for the user's password
    func login(email: String, password: String)
}

class LoginView: UIView {
    
    // MARK: Properties
    
    var delegate: LoginViewDelegate?
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = MembershipConstants.Login.headerTitle
        titleLabel.font = Fonts.Oxygen.header1
        titleLabel.textColor = UIColor(rgb: 0xF0F5F9)
        return titleLabel
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = MembershipConstants.Login.headerSubtitle
        subtitleLabel.font = Fonts.Oxygen.body2
        subtitleLabel.textColor = UIColor(rgb: 0xECF3F9)
        return subtitleLabel
    }()
    
    private let emailTextField: NCEmailTextField = {
        let emailTextField = NCEmailTextField()
        emailTextField.placeholder = MembershipConstants.Login.emailTextFieldPlaceholder
        emailTextField.backgroundColor = UIColor(rgb: 0xD1B99B)
        emailTextField.textColor = .label
        emailTextField.font = Fonts.Oxygen.title6
        emailTextField.layer.cornerRadius = 16
        emailTextField.layer.borderWidth = 0
        return emailTextField
    }()
    
    private let passwordTextField: NCPasswordTextField = {
        let passwordTextField = NCPasswordTextField()
        passwordTextField.placeholder = MembershipConstants.Login.passwordTextFieldPlaceholder
        passwordTextField.backgroundColor = UIColor(rgb: 0xD1B99B)
        passwordTextField.textColor = .label
        passwordTextField.font = Fonts.Oxygen.title6
        passwordTextField.layer.cornerRadius = 16
        passwordTextField.layer.borderWidth = 0
        return passwordTextField
    }()
    
    private let goToSignupLabel: UILabel = {
        let goToSignupLabel = UILabel()
        goToSignupLabel.text = "Don't have an account?"
        goToSignupLabel.textColor = UIColor(rgb: 0xECF3F9)
        goToSignupLabel.font = Fonts.Oxygen.subtitle2
        return goToSignupLabel
    }()
    
    private let goToSignupButton: UIButton = {
        let goToSignupButton = UIButton()
        goToSignupButton.setTitle(MembershipConstants.Login.toggleButtonTitle, for: .normal)
        goToSignupButton.setTitleColor(UIColor(rgb: 0x9BBFD1), for: .normal)
        goToSignupButton.addTarget(self, action: #selector(goToSignupButtonTapped), for: .touchUpInside)
        goToSignupButton.titleLabel?.font = Fonts.Oxygen.subtitle2
        return goToSignupButton
    }()
    
    private let goToSignupStack: UIStackView = {
        let goToSignupStack = UIStackView()
        goToSignupStack.axis = .horizontal
        goToSignupStack.spacing = 4
        return goToSignupStack
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle(MembershipConstants.Login.submitButtonTitle, for: .normal)
        loginButton.setTitleColor(UIColor(rgb: 0xECF3F9), for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.titleLabel?.font = Fonts.Oxygen.button1
        loginButton.backgroundColor = UIColor(rgb: 0x487185)
        loginButton.layer.cornerRadius = 16
        return loginButton
    }()
    
    private let stackContainer = UIView()
    
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
        stack.addArrangedSubview(passwordTextField)
        
        stackContainer.addSubview(stack)
        
        goToSignupStack.addArrangedSubviews([goToSignupLabel, goToSignupButton])

        addSubviews([titleLabel, subtitleLabel])
        addSubview(stackContainer)
        addSubview(loginButton)
        addSubview(goToSignupStack)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(64)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        stackContainer.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(loginButton.snp.top)
        }
        
        stack.snp.makeConstraints { make in
            make.centerY.greaterThanOrEqualToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(MembershipConstants.submitButtonHeight)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(MembershipConstants.submitButtonHeight)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(MembershipConstants.submitButtonHeight)
        }
        
        goToSignupStack.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin).inset(32)
        }
        
        goToSignupStack.isHidden = AuthKitManager.shared.membershipOption == .loginOnly ? true : false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundCorners(corners: [.topLeft, .topRight], radius: 8)
    }
    
    // MARK: Actions
    
    @objc private func loginButtonTapped() {
        if emailTextField.isFulfilled,
           passwordTextField.isFulfilled,
           let email = emailTextField.text,
           let password = passwordTextField.text {
            delegate?.login(email: email, password: password)
        } else {
            delegate?.errorFound(.generic)
        }
    }
    
    @objc private func goToSignupButtonTapped() {
        delegate?.toggleMembershipView(toShowLogin: false)
    }
    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
