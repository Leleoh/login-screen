//
//  AddTaskViewController.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 07/05/25.
//
import UIKit

protocol AddTaskDelegate: AnyObject {
    func didAddTask(task: Tasks)
}

class AddTaskViewController: UIViewController {
    
    
    lazy var tasksTextField: LabeledTextField = {
        let textField = LabeledTextField()
        textField.name = "Task"
        textField.placeholder = "Your task name here"
        return textField
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "list.bullet"))
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont(name: "SFProRounded-Medium", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    lazy var categorySelector = CategorySelector()
    
    lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont(name: "SFProRounded-Medium", size: 17)
        label.textColor = .label
        return label
    }()
    
    lazy var addDescription: UITextView = {
        let text = UITextView()
        text.text = "More details about the task"
        text.font = UIFont(name: "SFProRounded-Regular", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.cornerRadius = 8
        text.heightAnchor.constraint(equalToConstant: 112).isActive = true
        text.textColor = .placeholderText
        text.backgroundColor = UIColor.backgroundTertiary
        return text
    }()
    
    lazy var descriptionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [descriptionText, addDescription])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    lazy var mainStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [tasksTextField, categorySelector, descriptionStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    weak var delegate: AddTaskDelegate?
    
    @objc func cancelTapped(){
        dismiss(animated: true)
    }
    
    @objc func addTapped(){
        print("Adicionar tarefa pressionado")
        
        let newTask = Tasks(name: tasksTextField.text ?? "no name", category: categorySelector.selectedCategory ?? .other, description: addDescription.text ?? "", isDone: false)
        
        Persistance.addTask(newTask: newTask)
        
        cleanViewValues()
        
        let newtasklist = Persistance.getUserTask()
        newtasklist.tasks.forEach { print($0.name) }
        
        delegate?.didAddTask(task: newTask)
        dismiss(animated: true)
    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundSecondary
        title = "New task"
        
        tasksTextField.translatesAutoresizingMaskIntoConstraints = false
        addDescription.delegate = self
        
        
        //Botão de cancelar
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        //Botão de add
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        //Dismiss teclado
        let tapDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapDismissKeyboard)
        
        setup()
    }
    
    func cleanViewValues(){
        tasksTextField.text = ""
        addDescription.text = "More details about the task"
        addDescription.textColor = .placeholderText
        categorySelector.selectedCategory = nil
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
}//Fim da classe



extension AddTaskViewController: ViewCodeProtocol{
    
    func addSubViews() {
        //view.addSubview(tasksTextField)
        view.addSubview(mainStack)

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
//            tasksTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            tasksTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            tasksTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//
            addDescription.heightAnchor.constraint(equalToConstant: 112),
            
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
        ])
    }
}

extension AddTaskViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == "More details about the task" {
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                textView.text = "More details about the task"
                textView.textColor = .placeholderText
            }
        }
    
}
