//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/15/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class PlayerTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var players = [Player]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem

        // Load the sample data.
//        loadSamplePlayers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PlayerTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PlayerTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let players = self.players[indexPath.row]
        
        cell.nameLabel.text = players.name
        cell.photoImageView.image = players.photo
        //cell.ratingControl.rating = players.rating
        cell.photoImageView.layer.cornerRadius = cell.photoImageView.frame.size.height/2
        cell.photoImageView.layer.masksToBounds = true
        cell.photoImageView.layer.borderWidth = 0
       
        
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new player.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let playerDetailViewController = segue.destination as? PlayerCreationViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedPlayerCell = sender as? PlayerTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedPlayerCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedPlayer = players[indexPath.row]
            playerDetailViewController.player = selectedPlayer
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

    
    //MARK: Actions
    

    @IBAction func unwindToPlayerList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? PlayerCreationViewController, let player = sourceViewController.player {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                players[selectedIndexPath.row] = player
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: players.count, section: 0)
                
                players.append(player)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    //MARK: Private Methods
    
//    private func loadSamplePlayers() {
//
//        let photo1 = UIImage(named: "meal1")
//        let photo2 = UIImage(named: "meal2")
//        let photo3 = UIImage(named: "meal3")
//
//        guard let player1 = Player(name: "Caprese Salad", photo: photo1) else {
//            fatalError("Unable to instantiate meal1")
//        }
//
//        guard let player2 = Player(name: "Chicken and Potatoes", photo: photo2) else {
//            fatalError("Unable to instantiate meal2")
//        }
//
//        guard let player3 = Player(name: "Pasta with Meatballs", photo: photo3) else {
//            fatalError("Unable to instantiate meal2")
//        }
//
//        players += [player1, player2, player3
//        ]
//    }

}
