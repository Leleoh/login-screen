//
//  ViewController.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 29/04/25.
//

import UIKit

//Criando uma nova subclasse para lidar com o gradiente
class GradientView: UIView{
    
    //Trocando o CALayer genérico para o CAGradientLayer, fazemos isso pois por padrão o CAGradientLayer já sabe lidar com gradientes
    override class var layerClass: AnyClass{
        return CAGradientLayer.self //Vamos usar esse, o próprio para lidar com gradientes
    }
    
    //Função para aplicarmos posteriormente quando quisermos converter uma cor em gradiente vertical
    func configureGradient(colors: [UIColor]){
        
        //Desempacotamento para verificar se consegue fazer o casting para CAGradientLayer -> Layer -> gradientLayer
        guard let gradientLayer = layer as? CAGradientLayer else {return}
        gradientLayer.colors = colors.map {$0.cgColor}  //Transformando cada UIColor em CGColor
        
        //Degradê vertical de cima para baixo
        gradientLayer.startPoint = CGPoint(x:0.5, y : 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y : 1)
    }
}

class LoginViewController: UIViewController {

    // MARK: View Superior
    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome!"
        label.textAlignment = .center
        label.font = UIFont(name: "SFProRounded-Bold", size: 30)
        label.textColor = UIColor.white
        return label
    }()
    
    //Logo da apple
    lazy var appleInteligenceLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appleInteligenceLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 49),
                imageView.heightAnchor.constraint(equalToConstant: 48)
            ])
        return imageView
    }()
    
    //O gradiente em si
    lazy var blueGradient: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configureGradient(colors: [
            UIColor(named: "gradient1") ?? .blue,
            UIColor(named: "gradient2") ?? .systemCyan
        ])
        return view
    }()
    
    //Uma stack contendo o topo
    lazy var blueTopContainerStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [appleInteligenceLogo, welcomeLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 24
        stack.axis = .vertical  //Direção da disposição dos itens da stack
        stack.alignment = .center
        return stack
    }()
    
    // MARK: Login Area
    
    lazy var loginContainerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Background-Secondary")
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true   //Não permite que a view ultrapasse bordas
        return view
    }()
    
    lazy var loginLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.textAlignment = .center
        label.font = UIFont(name: "SFProRounded-Bold", size: 30)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.textAlignment = .left
        label.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "abc@abc.com"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none    //Evita maiscula automatica
        textField.autocorrectionType = .no
        textField.backgroundColor = .backgroundTertiary
        //Desativa a correção automática
        return textField
    }()
    
    lazy var emailStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    lazy var passwordLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        label.textAlignment = .left
        label.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "********"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.backgroundColor = .backgroundTertiary
        return passwordTextField
    }()
    
    lazy var forgotPassword: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Forgot Password?"
        label.textAlignment = .right
        label.font = UIFont(name: "SFProRounded-Regular", size: 17)
        label.textColor = UIColor.systemBlue
        return label
    }()
    
    lazy var passwordStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    lazy var emailandPassawordStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailStack, passwordStack, forgotPassword])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    // MARK: Botões
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProRounded-Bold", size: 17)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var caButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProRounded-Bold", size: 17)
        button.backgroundColor = UIColor.backgroundPrimary
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: Funções
    
    func loginError(){
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.red.cgColor
        emailTextField.layer.cornerRadius = 12
        emailTextField.clipsToBounds = true
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.red.cgColor
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.clipsToBounds = true
        
        let errorMessage = UILabel()
        errorMessage.text = "The email and password you entered did not match our record. Please try again."
        errorMessage.font = UIFont(name: "SFProRounded-Regular", size: 13)
        errorMessage.textColor = UIColor.red
        errorMessage.textAlignment = .center
        errorMessage.numberOfLines = 0
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorMessage)
        
        NSLayoutConstraint.activate([
            errorMessage.topAnchor.constraint(equalTo: emailandPassawordStack.bottomAnchor, constant: 53),
            errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)

        ])
        
        let alert = UIAlertController(title: "Erro", message: "Usuário ou senha inválidos!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func clearErrorState(){
        emailTextField.layer.borderWidth = 0
        emailTextField.layer.borderColor = UIColor.clear.cgColor
        
        passwordTextField.layer.borderWidth = 0
        passwordTextField.layer.borderColor = UIColor.clear.cgColor
        
        for subview in view.subviews{
            if let label = subview as? UILabel, label.text?.contains("The email and password") == true{
                label.removeFromSuperview()
            }
        }
        
    }
    
    func validateLogin(){
        clearErrorState()
        
        let savedEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        let savedPassword = UserDefaults.standard.string(forKey: "password") ?? ""
        
        let typedEmail = emailTextField.text ?? ""
        let typedPassword = passwordTextField.text ?? ""
        
        if typedEmail == savedEmail && typedPassword == savedPassword{
            print("Bem vindo \(typedEmail)")
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.changeRootViewController(TabBarController())
            }
        } else{
            print("Login inválido")
            loginError()
        }
        
    }
    
    lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginButton, caButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    @objc func createAccountPressed(){
        
        let backButton = UIBarButtonItem()
        backButton.title = "Login"
        navigationItem.backBarButtonItem = backButton
        
        let createVC = CreateAccountViewController()
        navigationController?.pushViewController(createVC, animated: true)
    }
    
    @objc func loginPressed(){
        validateLogin()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        caButton.addTarget(self, action: #selector(createAccountPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }

} //Fim da classe
    
extension LoginViewController : ViewCodeProtocol{
    func addSubViews() {
        view.addSubview(blueGradient)
        blueGradient.addSubview(blueTopContainerStack)
        view.addSubview(loginContainerView)
        loginContainerView.addSubview(loginLabel)
        view.addSubview(emailandPassawordStack)
        view.addSubview(buttonsStack)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
        
        blueGradient.topAnchor.constraint(equalTo: view.topAnchor),
        blueGradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        blueGradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        blueGradient.heightAnchor.constraint(equalToConstant: 300),

        blueTopContainerStack.centerXAnchor.constraint(equalTo: blueGradient.centerXAnchor),
        blueTopContainerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        
        loginContainerView.topAnchor.constraint(equalTo: blueGradient.bottomAnchor, constant: -30),
        loginContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        loginContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        loginContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        loginLabel.topAnchor.constraint(equalTo: loginContainerView.topAnchor, constant: 20),
        loginLabel.centerXAnchor.constraint(equalTo: loginContainerView.centerXAnchor),
        
        emailandPassawordStack.topAnchor.constraint(equalTo: blueGradient.bottomAnchor, constant: 56),
        emailandPassawordStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        emailandPassawordStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        emailTextField.heightAnchor.constraint(equalToConstant: 46),
        passwordTextField.heightAnchor.constraint(equalToConstant: 46),
        forgotPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        
        buttonsStack.topAnchor.constraint(equalTo: emailandPassawordStack.bottomAnchor, constant: 127),
        buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        loginButton.heightAnchor.constraint(equalToConstant: 46),
        caButton.heightAnchor.constraint(equalToConstant: 46)
        
        
        ])
    }
}

