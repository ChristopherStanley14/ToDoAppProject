//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Christopher Stanley on 10/18/16.
//  Copyright © 2016 Christopher Stanley. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    @IBOutlet weak var showAll: UISwitch!
    
    var completeButton: Int = 0
    
    //    let items = [["Test1.1", "Test1,2"], ["Test2.1", "Test2.2"], ["Test3.1", "Test3.2"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.showAll.isOn = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return NoteStore.shared.getCount(catagory: section)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoteTableViewCell.self)) as! NoteTableViewCell
        
        cell.setupCell(NoteStore.shared.getNote(indexPath.row, catagory: indexPath.section))
        
//        if completeButton == 1 {
//            if cell.isCompleted == true {
//                cell.isHidden = true
//                tableView.rowHeight = 0
//            } else {
//                cell.isHidden = false
//                tableView.rowHeight = 80
//            }
//        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if NoteStore.shared.getNote(indexPath.row, catagory: indexPath.section).completed == true {
            if showAll.isOn == false {
                return 0
            } else {
                return 80
            }
        } else {
            return 80
        }
    }
    
    
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if NoteStore.shared.getNote(indexPath.row, catagory: indexPath.section).completed == true {
//            if showAll == true {
//                return 0
//            } else {
//                return 80
//        } else {
//            return 80
//        }
//    }
//    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        switch (section) {
        case 0:
            return "Home"
        case 1:
            return "Work"
        default:
            return "Other"
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section == proposedDestinationIndexPath.section {
            return proposedDestinationIndexPath
        } else {
            return sourceIndexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            NoteStore.shared.deleteNote(indexPath.row, catagory: indexPath.section)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditNoteSegue" {
            let noteDetailVC = segue.destination as! NoteDetailViewController
            let tableCell = sender as! NoteTableViewCell
            noteDetailVC.note = tableCell.note
        }
        
    }
    
    
    @IBAction func showAllChanged(_ sender: AnyObject) {
        if showAll.isOn {
            completeButton = 1
            tableView.reloadData()
        } else {
            completeButton = 0
            tableView.reloadData()
        }
    }
    
    
    // MARK: - Unwind Segue
    @IBAction func saveNoteDetail(_ segue: UIStoryboardSegue) {
        let noteDetailVC = segue.source as! NoteDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            
            
            
            //            NoteStore.shared.sort()
            //
            //            tableView.reloadData()
            
            NoteStore.shared.deleteNote(indexPath.row, catagory: indexPath.section)
            NoteStore.shared.addNote(noteDetailVC.note, catagory: indexPath.section)
            tableView.reloadData()
            //            NoteStore.shared.updateNote(noteDetailVC.note, index: indexPath.row)
            //            NoteStore.shared.sort()
            //
            //            var indexPaths: [IndexPath] = []
            //            for index in 0...indexPath.row {
            //                indexPaths.append(IndexPath(row: index, section: 0))
            //            }
            //
            //            tableView.reloadRows(at: indexPaths, with: .automatic)
        } else {
            let indexPath = IndexPath(row: 0, section: noteDetailVC.note.catagory)
            NoteStore.shared.addNote(noteDetailVC.note, catagory: indexPath.section)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}

