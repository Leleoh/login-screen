//
//  EditTaskViewController.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 09/05/25.
//

import UIKit

class EditTaskViewController: AddTaskViewController {
    var taskToEdit: Tasks!
        
    lazy var isDoneButton: UIButton = {
        let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tintColor = .systemBlue
            button.setImage(UIImage(systemName: "circle"), for: .normal)
            button.addTarget(self, action: #selector(toggleDoneStatus), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: 28).isActive = true
            button.heightAnchor.constraint(equalToConstant: 28).isActive = true
            return button
    }()
    
    func updateIsDoneButtonAppearance() {
        let imageName = taskToEdit.isDone ? "checkmark.circle.fill" : "circle"
            isDoneButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc func toggleDoneStatus() {
        taskToEdit.isDone.toggle()
        updateIsDoneButtonAppearance()
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            title = "Taks details"
            tasksTextField.text = taskToEdit.name
            categorySelector.selectedCategory = taskToEdit.category
            addDescription.text = taskToEdit.description
            addDescription.textColor = .label
            
            updateIsDoneButtonAppearance()
            
            
            // Exibe um rótulo e botão na mesma linha
                let isDoneLabel = UILabel()
                isDoneLabel.text = "Status"
                isDoneLabel.font = UIFont(name: "SFProRounded-Medium", size: 17)
                isDoneLabel.textColor = .label
                
                let isDoneStack = UIStackView(arrangedSubviews: [isDoneButton, isDoneLabel])
                isDoneStack.axis = .horizontal
                isDoneStack.spacing = 12
                isDoneStack.alignment = .center
                
                mainStack.addArrangedSubview(isDoneStack)
                
            // Trocar o botão de "Add" para "Save"
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(saveTapped)
            )
        }

        @objc func saveTapped() {
            let updatedTask = Tasks(
                id: taskToEdit.id, // manter o ID original
                name: tasksTextField.text ?? "",
                category: categorySelector.selectedCategory ?? .other,
                description: addDescription.text ?? "",
                isDone: taskToEdit.isDone // manter o estado de "feito"
            )
            
            Persistance.updateTask(updatedTask)
            delegate?.didAddTask(task: updatedTask)
            dismiss(animated: true)
        }
    
}
