//
//  Persistance.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 08/05/25.
//

import Foundation

struct Persistance {
    private static let key = "tasks"
    
    private static let loggedKey = "userLogged"
    
    static func getUserTask() -> TaskList {
        
        if let data = UserDefaults.standard.data(forKey: key) {
            
            do {
                let savedTaskList = try JSONDecoder().decode(TaskList.self, from: data)
                return savedTaskList
            }catch{
                print(error.localizedDescription)
            }
        }
        
        let newTaskList = TaskList()
        save(tasklist: newTaskList)
        
        return newTaskList
    }
    
    static func addTask(newTask: Tasks){
        var currentList = getUserTask()
        currentList.tasks.append(newTask)
        save(tasklist: currentList)
    }
    
    static func save(tasklist: TaskList){
        do {
            let data = try JSONEncoder().encode(tasklist)
            UserDefaults.standard.set(data, forKey: key)
        } catch{
            print(error.localizedDescription)
        }
    }
    
    static func deleteTask(by id: UUID){
        var allTasks = getUserTask().tasks
        allTasks.removeAll { $0.id == id }
        save(tasklist: TaskList(tasks: allTasks))
    }
    
    static func updateTask(_ updatedTask: Tasks) {
        var taskList = getUserTask()
        
        if let index = taskList.tasks.firstIndex(where: { $0.id == updatedTask.id }) {
            taskList.tasks[index] = updatedTask
            save(tasklist: taskList)
        }
    }
}//Fim da struct

