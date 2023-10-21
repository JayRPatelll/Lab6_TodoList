//
//  TableViewController.swift
//  Lab6_TableViewController
//
//  Created by user232336 on 10/16/23.
//

import UIKit

class TableViewController: UITableViewController {

    var toDoItems: [String] = []
    override func viewDidLoad() 	{
        super.viewDidLoad()

        if let savedItems = UserDefaults.standard.stringArray(forKey: "ToDoItemsKey"){
            toDoItems = savedItems
        }
    }
    // to store userdefault data
    func saveToDoItems(){
        UserDefaults.standard.set(toDoItems, forKey: "ToDoItemsKey")
    }
    // function for alert boc to add item
    func addAlertButton(){
        let addAlert = UIAlertController(title: "welcome", message: "Enter Item name",
                                      preferredStyle: .alert)
        addAlert.addTextField{
            fields in fields.placeholder = "Write an Item"
        }
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        addAlert.addAction(UIAlertAction(title: "OK", style: .default,handler: { _ in
            guard let field = addAlert.textFields else {return}
            let textField = field[0]
            if let item = textField.text{
                self.toDoItems.insert(item, at:0)
                //self.toDoItems.append(item)
                self.tblView.reloadData()
                self.saveToDoItems()
            }
        }
            ))
            present(addAlert, animated: true,completion: nil)
    }
    
    @IBAction func addItem(_ sender: Any) {
        addAlertButton()
    }
    
    
    @IBOutlet var tblView: UITableView!
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowCell", for: indexPath)
        cell.textLabel?.text = toDoItems[indexPath.row]

        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    // to delete item by swipping
    func deleteFunc(at indexPath:IndexPath){
        toDoItems.remove(at: indexPath.row)
        saveToDoItems()
        tblView.deleteRows(at: [indexPath], with: .fade)
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFunc(at: indexPath)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        //let replacedItem = toDoItems.remove(at: fromIndexPath.row)
        //toDoItems.insert(replacedItem, at: to.row)
        toDoItems.swapAt(fromIndexPath.row, to.row)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
