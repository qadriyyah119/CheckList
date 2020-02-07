//
//  ToDoList.swift
//  CheckList
//
//  Created by Qadriyyah Griffin on 1/21/20.
//  Copyright © 2020 Qadriyyah Thomas. All rights reserved.
//

import Foundation

class TodoList {
  
  enum Priority: Int, CaseIterable {
    case high, medium, low, no
  }
  
  // var is private because we only want the todos to be manipulated from the TodoList class not from outside this class
  private var highPriorityTodos: [ChecklistItem] = []
  private var mediumPriorityTodos: [ChecklistItem] = []
  private var lowPriorityTodos: [ChecklistItem] = []
  private var noPriorityTodos: [ChecklistItem] = []
  
  init() {
    
    let row0Item = ChecklistItem()
    let row1Item = ChecklistItem()
    let row2Item = ChecklistItem()
    let row3Item = ChecklistItem()
    let row4Item = ChecklistItem()
    let row5Item = ChecklistItem()
    let row6Item = ChecklistItem()
    let row7Item = ChecklistItem()
    let row8Item = ChecklistItem()
    let row9Item = ChecklistItem()
    
    row0Item.text = "Take a jog"
    row1Item.text = "Watch a movie"
    row2Item.text = "code an app"
    row3Item.text = "Walk the dog"
    row4Item.text = "Study design patterns"
    row5Item.text = "Take a hike"
    row6Item.text = "Watch a tutorial"
    row7Item.text = "code for practice"
    row8Item.text = "Do leg workout"
    row9Item.text = "Study making tables"
    
    addTodo(row0Item, for: .medium)
    addTodo(row1Item, for: .low)
    addTodo(row2Item, for: .no)
    addTodo(row3Item, for: .high)
    addTodo(row4Item, for: .high)
    addTodo(row5Item, for: .medium)
    addTodo(row6Item, for: .low)
    addTodo(row7Item, for: .no)
    addTodo(row8Item, for: .high)
    addTodo(row9Item, for: .high)
  }
  
  func addTodo(_ item: ChecklistItem, for priority: Priority, at index: Int = -1) {
    switch priority {
    case .high:
      if index < 0 {
        highPriorityTodos.append(item)
      } else {
        highPriorityTodos.insert(item, at: index)
      }
    case .medium:
      if index < 0 {
        mediumPriorityTodos.append(item)
      } else {
        mediumPriorityTodos.insert(item, at: index)
      }
    case .low:
      if index < 0 {
        lowPriorityTodos.append(item)
      } else {
        lowPriorityTodos.insert(item, at: index)
      }
    case .no:
      if index < 0 {
        noPriorityTodos.append(item)
      } else {
        noPriorityTodos.insert(item, at: index)
      }
    }
  }
  
  func todoList(for priority: Priority) -> [ChecklistItem] {
    switch priority {
    case .high:
      return highPriorityTodos
    case .medium:
      return mediumPriorityTodos
    case .low:
      return lowPriorityTodos
    case .no:
      return noPriorityTodos
    }
  }
  
  func newTodo() -> ChecklistItem {
    let item = ChecklistItem()
    item.text = randomTitle()
    item.checked = true
    mediumPriorityTodos.append(item)
    return item 
  }
  
  func move(item: ChecklistItem, from sourcePriority: Priority, at sourceIndex: Int, to destinationPriority: Priority, at destinationIndex: Int) {
    remove(item, from: sourcePriority, at: sourceIndex)
    addTodo(item, for: destinationPriority, at: destinationIndex)
    
  }
  
  func remove(_ item: ChecklistItem, from priority: Priority, at index: Int) {
    switch priority {
    case .high:
      highPriorityTodos.remove(at: index)
    case .medium:
      mediumPriorityTodos.remove(at: index)
    case .low:
      lowPriorityTodos.remove(at: index)
    case .no:
      noPriorityTodos.remove(at: index)
    }
  }
  
  private func randomTitle () -> String {
    var titles = ["New todo item", "Generic todo", "Fill me out", "I need something to do", "Much todo about nothing"]
  let randomNumber = Int.random(in: 0...titles.count - 1)
  return titles[randomNumber]
  }
  
}
