//
//  CategorySelector.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 07/05/25.
//

import UIKit

class CategorySelector: UIView {
    
    lazy var label: UILabel = {
        var label = UILabel()
        label.text = "Category"
        label.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        return label
    }()
    
    lazy var button: UIButton = {
        var button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Select"
        configuration.indicator = .popup
        button.configuration = configuration
        
        button.menu = UIMenu(title: "Category", options: [.singleSelection], children: categorySelector)
        button.showsMenuAsPrimaryAction = true
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "list.bullet"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        
        let imageSize: CGFloat = 20
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: imageSize),
                imageView.heightAnchor.constraint(equalToConstant: imageSize),
            ])
        return imageView
    }()
    
    lazy var iconContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 7
        //container.backgroundColor = .Colors.accent
        container.clipsToBounds = true
        container.backgroundColor = UIColor.systemBlue

        container.addSubview(icon)
        NSLayoutConstraint.activate([

            container.widthAnchor.constraint(equalToConstant: 30),
            container.heightAnchor.constraint(equalToConstant: 30),

            icon.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        ])

        return container
    }()
    
    lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [iconContainer, label, button])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.spacing = 12
        return stack
    }()
    
    private var categorySelector: [UIAction] {
        return Category.allCases.sorted(by: { $0.rawValue < $1.rawValue })
            .map { category in
                UIAction(
                    title: category.rawValue.capitalized,
                    image: UIImage(systemName: category.imageName),
                    handler: { [weak self] _ in
                        self?.selectedCategory = category
                    }
                )
            }
    }
    
    var selectedCategory: Category? {
        didSet {
            button.setTitle(selectedCategory?.rawValue ?? "Select", for: .normal)
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

extension CategorySelector: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.heightAnchor.constraint(equalToConstant: 46),

//            iconContainer.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 16),
        ])
    }
}
