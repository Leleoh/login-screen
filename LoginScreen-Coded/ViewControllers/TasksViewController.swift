//
//  TasksViewController.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 06/05/25.
//

import UIKit

class TasksViewController: UIViewController {
    
    // MARK: Subviews de vazio
    //Logo de vazio
    lazy var taskEmpty: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "TasksLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //Label de vazio
    lazy var noTasksLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No tasks yet!"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProRounded-Bold", size: 17)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var messageAddTaskLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add a new task and it will show up here."
        label.textColor = UIColor.labelSecondary
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProRounded-Light", size: 17)
        return label
    }()
    
    lazy var messagesStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [noTasksLabel, messageAddTaskLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    //Stack final a ser apresentada para vazio
    lazy var noTasksStack : UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [taskEmpty, messagesStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    
    // MARK: Tables
    lazy var addNewTaskButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add new task", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProRounded-Bold", size: 17)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.systemBlue
        return button
    }()
    
    lazy var noTasksStackView : UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [noTasksStack, addNewTaskButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 32
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "default-cell")
        table.register(TasksViewCell.self , forCellReuseIdentifier: TasksViewCell.reuseIdentifier)
        return table
    }()
    
    func setupNavigationBar() {
        title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTaskTapped))
    }
    
    @objc func addNewTaskTapped() {
        print("Add new task tapped")
        let addTaskVC = AddTaskViewController()
        addTaskVC.delegate = self
        let navigationController = UINavigationController(rootViewController: addTaskVC)
        navigationController.modalPresentationStyle = .automatic
        present(navigationController, animated: true, completion: nil)
    }
    
    var tasklist = Persistance.getUserTask(){
        didSet{
            buildContent()
            tableView.reloadData()
        }
    }
    
    var sections: [Category] = []
    var rows: [[Tasks]] = []
    
    func buildContent(){
        sections = buildSections()
        rows = buildRows()
    }
    
    func buildSections() -> [Category] {
        var categories: [Category] = []
        
        for category in Category.allCases {
            let hasCategoryTasks = tasklist.tasks.contains(where: { $0.category == category })
            if hasCategoryTasks {
                categories.append(category)
            }
        }
        return categories
    }
    
    func buildRows() -> [[Tasks]] {
        var rows: [[Tasks]] = []
        
        for section in sections {
            rows.append(tasklist.tasks.filter({$0.category == section}))
        }
        return rows
    }
    
    func getTask(by indexPath: IndexPath) -> Tasks {
        let tasksOfSection = rows[indexPath.section]
        let task = tasksOfSection[indexPath.row]
        return task
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundPrimary
        setupNavigationBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        buildContent()
        setup()
    }
    
} //Fim da classe

extension TasksViewController: AddTaskDelegate{
    func didAddTask(task: Tasks) {
        tasklist = Persistance.getUserTask()
    }
}

extension TasksViewController: ViewCodeProtocol{
    func addSubViews() {
        view.addSubview(noTasksStackView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            noTasksStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noTasksStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noTasksStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            

            taskEmpty.heightAnchor.constraint(equalToConstant: 92),
            taskEmpty.widthAnchor.constraint(equalToConstant: 67),
            
            
            addNewTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addNewTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addNewTaskButton.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

// MARK: UITableViewDelegate
extension TasksViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let task = getTask(by: indexPath)
        let editVC = EditTaskViewController()
        editVC.taskToEdit = task
        editVC.delegate = self
        let nav = UINavigationController(rootViewController: editVC)
        present(nav, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] (action, view, completionHandler) in
            
            if let taskToDelete = self?.getTask(by: indexPath) {
                Persistance.deleteTask(by: taskToDelete.id)
                self?.tasklist = Persistance.getUserTask()
            }
            
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipe
        
    }
}

// MARK: UITableViewDataSource
extension TasksViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        containerView.backgroundColor = UIColor.backgroundSecondary

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.secondaryLabel
        label.text = sections[section].rawValue.capitalized
        
        containerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        return containerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].rawValue.capitalizingFirstLetter()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        noTasksStackView.isHidden = !sections.isEmpty
        tableView.isHidden = sections.isEmpty
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TasksViewCell.reuseIdentifier, for: indexPath) as? TasksViewCell else {
            return UITableViewCell()
        }
        
        let task = getTask(by: indexPath)
        
        cell.config(labelText: task.name, isDone: task.isDone) { [weak self] in
            guard var tasktoUpdate = self?.getTask(by: indexPath) else { return }
            tasktoUpdate.isDone.toggle()
            Persistance.updateTask(tasktoUpdate)
            self?.tasklist = Persistance.getUserTask()
        }
        
        return cell
    }
    
}
