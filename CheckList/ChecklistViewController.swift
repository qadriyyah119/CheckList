//
//  ViewController.swift
//  CheckList
//
//  Created by Qadriyyah Griffin on 1/21/20.
//  Copyright © 2020 Qadriyyah Thomas. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
  
  var todoList: TodoList // variable of type TodoList class. Has access to all properties in TodoList class located in ToDoList.swift
  
  // function that's taking in an index(Int) and returning a Priority case from the enum created in the TodoList class-(ToDoList.swift) or nil if there is no index selected
  // The rawValue is the index number starting from 0
  private func priorityForSectionIndex(_ index: Int) -> TodoList.Priority? {
    return TodoList.Priority(rawValue: index)
  }
  
  // IBAction function when "+" button is pressed by user
  @IBAction func additem(_ sender: Any) {
    // the todoList variable is calling the todoList method from the ToDoList class
    // that method is returning an array of checklist items, hence why we need to use .count
    let newRowIndex = todoList.todoList(for: .medium).count
    _ = todoList.newTodo() // the newTodo method from the TodoList class is being called to append the new checklist item to the medium priority list and return the item
    // IndexPath is taking the new checklist item that's been assigned to newRowIndex and the section ??? -> (why is it 0)
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    // indexPaths is taking the current indexPath from the line above
    let indexPaths = [indexPath]
    // this method is called to insert the rows in the tableView at the location taken from the indexPaths array index from the
    // line above.
    tableView.insertRows(at: indexPaths, with: .automatic)
  }
  
  //IBAction function when "Delete" button is pressed by user
  @IBAction func deleteItems(_ sender: Any) {
    // if the .indexPathsForSelectedRows returns an index path of the selected row(s), assign it to selectedRows
    if let selectedRows = tableView.indexPathsForSelectedRows {
      // then loop through each index path in the selectedRows constant
      for indexPath in selectedRows {
        // calling the priorityForSectionIndex func and if theres a priority case index for the indexPath section, return that priority case from the enum created in the TodoList class-(ToDoList.swift) and assign it to priority.
        if let priority = priorityForSectionIndex(indexPath.section) {
          // this is calling the todoList method on the TodoList class(ToDoList.swift) and returning an array of checklist items for the priority passed in and assigning them to the constant todos
          let todos = todoList.todoList(for: priority)
          // ??? why are we using todos.count - 1?
          let rowToDelete = indexPath.row > todos.count - 1 ? todos.count - 1 : indexPath.row
          let item = todos[rowToDelete]
          todoList.remove(item, from: priority, at: rowToDelete)
        }
      }
      tableView.beginUpdates()
      tableView.deleteRows(at: selectedRows, with: .automatic)
      tableView.endUpdates()
    }
  }
  
  // ???
  required init?(coder aDecoder: NSCoder) {
    
    todoList = TodoList()
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.leftBarButtonItem = editButtonItem
    tableView.allowsMultipleSelectionDuringEditing = true
  }
  
  // func that sets the view controller in an editable view or not
  // takes an editing parameter and if true will display an editable view and animated if true animates the transition
  override func setEditing(_ editing: Bool, animated: Bool) {
    // super is being used because we're overriding the function
    super.setEditing(editing, animated: true)
    // this line checks to see if controller is in editing state.
    tableView.setEditing(tableView.isEditing, animated: true)
  }
  
  // func used to provide the number of rows in a section
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // calling the priorityForSectionIndex func and if theres a priority case index, return that priority case from the enum created in the TodoList class-(ToDoList.swift) and assign it to priority.
    if let priority = priorityForSectionIndex(section) {
        // this is calling the todoList method on the TodoList class(ToDoList.swift) and returning an array of checklist items for the priority passed in. .count is then used and this will tell the func the number of rows needed in that section.
      return todoList.todoList(for: priority).count
    }
    return 0 // ??? Not clear on why we're returning 0
  }
  
  // This function is called every time we need to provide a table view cell on the screen. Takes the parameter, tableView to identify the table view this function is being called on and another parameter, indexPath which indentifies the cell's row and section indices. It returns a UITableViewCall
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // we take dequeueResuableCell function to dequeue a cell with the identifier "ChecklistItem" so it knows what type of cell we want and assigns it to the constant "cell"
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    // the priorityForSectionIndex function is called and if there's an indexPath.section, it's being assigned to the constant priority
    if let priority = priorityForSectionIndex(indexPath.section) {
    // this is calling the todoList method on the TodoList class(ToDoList.swift) and returning an array of checklist items for the priority passed in and assigning them to the constant items
      let items = todoList.todoList(for: priority)
    // here we are taking one checklist item from the items constant and it's row and assigning it to the constant item
      let item = items[indexPath.row]
    // here we're calling the configureText function from below passing in the cell from above and the item and setting the text to this cell.
      configureText(for: cell, with: item)
    // here we're calling the configureCheckmark function from below to see if a checkmark should appear next to the text.
      configureCheckmark(for: cell, with: item)
    }
    
    return cell
  }
  
  // function is called when a user taps the cell of the table view. Takes the tableView parameter and the indexPath of the cell that's being tapped
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // is the table view in editing mode? If true exit, if false go to the next block of code. The default value is always false
    if tableView.isEditing {
      return
    }
    // calling the cellForRow function on the tableView to get the indexPath of the cell that was tapped and assigning it to the constant cell.
    if let cell = tableView.cellForRow(at: indexPath) {
      // calling priorityForSectionIndex function to get the priority for the indexPath of the cell that was tapped and assigning it to the constant priority.
      if let priority = priorityForSectionIndex(indexPath.section) {
        // this is calling the todoList method on the TodoList class(ToDoList.swift) and returning an array of checklist items for the priority passed in and assigning them to the constant items
        let items = todoList.todoList(for: priority)
        // here we are taking one checklist item from the items constant and it's row and assigning it to the constant item
        let item = items[indexPath.row]
        // we're calling the toggleChecked method on the ChecklistItem class to change the checked var to checked.
        item.toggleChecked()
        // here we're calling the configureCheckmark function from below to add the checkmark to the checkmark label.
        configureCheckmark(for: cell, with: item)
        // deselectRow function is now called to unselect the row
        tableView.deselectRow(at: indexPath, animated: true)
      }
    }
  }
  
  // function to commit the changes of deletion of rows in tableView
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    // calling priorityForSectionIndex function to get the priority for the indexPath of the cell that was tapped and assigning it to the constant priority.
    if let priority = priorityForSectionIndex(indexPath.section) {
      // this is calling the todoList method on the TodoList class(ToDoList.swift) and returning an array of checklist items for the priority passed in and the individual indexPath row of the checklist item being edited. Then assigning it to the constant item
      let item = todoList.todoList(for: priority)[indexPath.row]
      // calling the remove method on the TodoList class passing in the item, from the priority at the indexPath row
      todoList.remove(item, from: priority, at: indexPath.row)
      // taking the indexPath being passed into the original func in the form of an array and assigning it to the constant indexPaths
      let indexPaths = [indexPath]
      // deleteRows function being called on tableView to delete the rows of index paths in the array assigned in the line above
      tableView.deleteRows(at: indexPaths, with: .automatic)
    }
  }
  
  //func to create move indicators that allow user to move checklist items when Edit button is selected
  // ??? need assistance with explaining this line by line
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
   
    if let srcPriority = priorityForSectionIndex(sourceIndexPath.section),
      let destPriority = priorityForSectionIndex(destinationIndexPath.section) {
      
      let item = todoList.todoList(for: srcPriority)[sourceIndexPath.row]
      todoList.move(item: item, from: srcPriority, at: sourceIndexPath.row, to: destPriority, at: destinationIndexPath.row)
    }
    
    tableView.reloadData()
  }
  
  // function used to set text to a table view cell. It takes a cell parameter: a UITableViewCall and an item: a ChecklistItem.
  func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
    // optional downcasting: if cell(UITableViewCell) is of type ChecklistTableViewCell assign it to checkmarkCell
    if let checkmarkCell = cell as? ChecklistTableViewCell {
        // Every instance of UITableViewCell has a property textLabel of UILabel, and every label of that type has a property text. We use it to set the text on the label.
        // take the text from the item(ChecklistItem) and assign the text to the todoTextLabel text field in the checkmarkCell
      checkmarkCell.todoTextLabel.text = item.text
    }
  }

  // It takes a cell parameter: a UITableViewCall and an item: a ChecklistItem.
  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
    // optional downcasting using guard: if cell(UITableViewCell) is of type ChecklistTableViewCell assign it to checkmarkCell and not exit the function
    guard let checkmarkCell =  cell as? ChecklistTableViewCell else {
      return
    }
    // if the item.checked(ChecklistItem class property checked = true) assign the text for the checkmarkLabel to "√". In other words, if the user taps the checklist item a checkmark will appear and if not nothing will appear
    if item.checked {
      checkmarkCell.checkmarkLabel.text = "√"
    } else {
      checkmarkCell.checkmarkLabel.text = ""
    }
  }
  // ??? Still working on understanding how to explain the Segue in my own words.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddItemSegue" {
      if let itemDetailViewController = segue.destination as? ItemDetailViewController {
        itemDetailViewController.delegate = self
        itemDetailViewController.todoList = todoList
      }
    } else if segue.identifier == "EditItemSegue" {
      if let itemDetailViewController = segue.destination as? ItemDetailViewController {
        if let cell = sender as? UITableViewCell,
          let indexPath = tableView.indexPath(for: cell),
          let priority = priorityForSectionIndex(indexPath.section)
          {
            
          let item = todoList.todoList(for: priority)[indexPath.row]
          itemDetailViewController.itemToEdit = item
          itemDetailViewController.delegate = self
        }
      }
    }
  }
  
  // function to set number of sections needed in tableview
  override func numberOfSections(in tableView: UITableView) -> Int {
    // returns total Int value based on the TodoList priority enum cases
    return TodoList.Priority.allCases.count
  }
  
  // function that sets title headers for each section. Returns a Priority String is one is available and if not returns nil
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    // set variable title as an optional String to nil
    var title: String? = nil
    // Switch case uses priorityForSectionIndex function to return the each TodoList Priority index and assign the titles based on the section
    if let priority = priorityForSectionIndex(section) {
      switch priority {
      case .high:
        title = "High Priority Todos"
      case .medium:
        title = "Medium Priority Todos"
      case .low:
        title = "Low Priority Todos"
      case .no:
        title = "Someday Todo Items"
      }
    }
    return title 
  }
  
}

// ??? Still working on the extensions
extension ChecklistViewController: ItemDetailViewControllerDelegate {
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
    navigationController?.popViewController(animated: true)
    let rowIndex = todoList.todoList(for: .medium).count - 1
    let indexPath = IndexPath(row: rowIndex, section: TodoList.Priority.medium.rawValue)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
    
    for priority in TodoList.Priority.allCases {
      let currentList = todoList.todoList(for: priority)
      if let index = currentList.firstIndex(of: item) {
        let indexPath = IndexPath(row: index, section: priority.rawValue)
        if let cell = tableView.cellForRow(at: indexPath) {
          configureText(for: cell, with: item)
        }
      }
    }
    navigationController?.popViewController(animated: true)
  }
  
  
}
