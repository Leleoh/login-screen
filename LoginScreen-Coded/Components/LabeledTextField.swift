//
//  LabeledTextField.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 02/05/25.
//

import UIKit

class LabeledTextField: UIView {
    
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Full name"
        label.font = UIFont(name: "SFProRounded-Semibold", size: 16)
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Your name"
        textField.font = UIFont(name: "SFProRounded-Regular", size: 17)
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 12
        textField.backgroundColor = UIColor.backgroundTertiary
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var nameStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    var name: String?{
        didSet{
            nameLabel.text = name
        }
    }
    
    var placeholder: String?{
        didSet{
            nameTextField.placeholder = placeholder
        }
    }
    
    var text: String? {
        get {
            nameTextField.text
        }
        set {
            nameTextField.text = newValue
        }
    }
    
    var delegate: UITextFieldDelegate? {
        didSet {
            nameTextField.delegate = delegate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
extension LabeledTextField: ViewCodeProtocol {
    
    func addSubViews() {
        addSubview(nameStack)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            nameStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameStack.topAnchor.constraint(equalTo: self.topAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 46)
        ])   
    }
}
