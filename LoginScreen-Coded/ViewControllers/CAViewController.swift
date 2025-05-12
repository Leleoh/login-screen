//
//  CAViewController.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 02/05/25.
//
import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate{
    
    //Título
    lazy var createAccount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create Account"
        label.textAlignment = .center
        label.font = UIFont(name: "SFProRounded-Bold", size: 30)
        label.textColor = UIColor.label
        return label
    }()
    
    //Componente para o nome
    lazy var nameTextField: LabeledTextField = {
        let textField = LabeledTextField()
        textField.name = "Full Name"
        textField.placeholder = "Your name here"
        return textField
    }()
    
    //Parte da data
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date of Birth"
        label.font = UIFont(name: "SFProRounded-Semibold", size: 16)
        return label
    }()
        
    lazy var dateOfBirth: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .systemBlue
        datePicker.setValue(UIColor.white, forKey: "textColor")
        return datePicker
    }()
    
    lazy var dataofBirthStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dateLabel, dateOfBirth])
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()
    
    //Componente para o e-mail
    lazy var emailTextField: LabeledTextField = {
        let textField = LabeledTextField()
        textField.name = "Email"
        textField.placeholder = "abc@abc.com"
        return textField
    }()
    
    //Componente para a senha
    lazy var passwordTextField: LabeledTextField = {
        let textField = LabeledTextField()
        textField.name = "Password"
        textField.placeholder = "Must be 8 characters"
        return textField
    }()
    
    //Parte dos termos
    lazy var termsButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.isOn = false
        return switchButton
    }()
    
    lazy var terms: UILabel = {
        let label = UILabel()
        label.text = "I accept the term and privacy policy"
        label.font = UIFont(name: "SFProRounded-Regular", size: 17)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var passwordRequirementsLabel: UILabel = {
        let label = UILabel()
        label.text = "The password does not meet requirements. It must be at least 8 characters long, containing a number, an uppercase letter, and a special character."
        label.font = UIFont(name: "SFProRounded-Semibold", size: 13)
        label.textColor = UIColor.systemRed
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    lazy var termsAcceptanceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [termsButton, terms])
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()
    
    //Stack mãe contendo os conteúdos do CA
    lazy var caSTACK: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTextField, dataofBirthStack, emailTextField, passwordTextField, passwordRequirementsLabel, termsAcceptanceStack])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    //Botão de criar conta
    lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    //Função para salvar o usuário cadastrado
    func saveUserData(){
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "name")
        defaults.set(email, forKey: "email")
        defaults.set(password, forKey: "password")
        
        //Imprime o que foi salvo para controle TIRAR DEPOIS
        print("Nome salvo: \(defaults.string(forKey: "name") ?? "nil")")
        print("Email salvo: \(defaults.string(forKey: "email") ?? "nil")")
        print("Senha salva: \(defaults.string(forKey: "password") ?? "nil")")
        
        let alert = UIAlertController(title: "Parabéns", message: "Conta criada com sucesso!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
        
    }

    
    //Ação para quando o botão de criar conta for pressionado
    @objc func createAccountPressed(){
        saveUserData()
        print("dados salvos")
    }
    
    @objc func passwordDidChange(){
        guard let password = passwordTextField.text else { return }
        
        let Requirements = isPasswordValid(password)
        passwordRequirementsLabel.isHidden = Requirements
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let minLength = password.count >= 8
        let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasNumber = password.range(of: "[0-9]", options: .regularExpression) != nil
        let hasSpecialCharacter = password.range(of: "[!@#$%^&*(),.?\":{}|<>]", options: .regularExpression) != nil

        
        return minLength && hasUppercase && hasNumber
    }
        
    //let passwordRequirementsView = PasswordRequirements() IMPLEMENTAR UM DIA
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundSecondary
        view.addSubview(createAccount)
        view.addSubview(caSTACK)
        view.addSubview(createAccountButton)
        
        passwordTextField.nameTextField.delegate = self
        passwordTextField.nameTextField.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
        
        //Chama a função após o botão ser pressionado
        createAccountButton.addTarget(self, action: #selector(createAccountPressed), for: .touchUpInside)
        

        
        //Comando maligno que o GPT passou pra conseguir pintar o texto da data
        if #available(iOS 14.0, *){
            UILabel.appearance(whenContainedInInstancesOf:  [UIDatePicker.self]).textColor = UIColor.systemBlue.withAlphaComponent(1)
        }
        
        NSLayoutConstraint.activate([
            createAccount.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            createAccount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createAccount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            caSTACK.topAnchor.constraint(equalTo: createAccount.bottomAnchor, constant: 32),
            caSTACK.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            caSTACK.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            //createAccountButton.topAnchor.constraint(equalTo: caSTACK.bottomAnchor, constant: 32),
            createAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -66),
            createAccountButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            createAccountButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            createAccountButton.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
}

