//
//  Untitled.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 09/05/25.
//

import UIKit

class NamedSwitch: UIView{
    
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        return label
    }()
    
    lazy var theswitcher: UISwitch = {
        var switcherControl = UISwitch()
        switcherControl.isOn = false
        return switcherControl
    }()
    
    lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [nameLabel, theswitcher])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        stack.alignment = .center
        return stack
    }()
    
    // MARK: Properties
    
    var name: String? {
        didSet{
            nameLabel.text = name
        }
    }
    
    var isOn: Bool = false{
        didSet{
            theswitcher.isOn = isOn
        }
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}//Fim da classe


extension NamedSwitch: ViewCodeProtocol{
    func addSubViews() {
        addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
}
