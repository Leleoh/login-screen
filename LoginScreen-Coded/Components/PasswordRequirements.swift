//
//  PasswordRequirements.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 05/05/25.
//
import UIKit

class PasswordRequirements: UIView{
    
    lazy var iconImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Wrong")
        return imageView
    }()
    
    lazy var requirementLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont(name: "SFProRounded-Regular", size: 13)
        return label
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, requirementLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var text: String?{
        didSet{
            requirementLabel.text = text
        }
    }
    
    var nicePassword: Bool = false{
        didSet{
            updateAppaerance()
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
    
extension PasswordRequirements: ViewCodeProtocol{
    func addSubViews() {
        addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 9),
            iconImageView.heightAnchor.constraint(equalToConstant: 9)
        ])
    }
    
    func updateAppaerance(){
        let imageName = nicePassword ? "Check":"Wrong"
        iconImageView.image = UIImage(named: imageName)
        requirementLabel.textColor = nicePassword ? .systemGreen : .secondaryLabel
    }
}
    

    
    

