//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Colin Horsford on 9/18/16.
//  Copyright © 2016 Paerdegat. All rights reserved.
//

/* A functioning table view requires three table view data source methods.

func numberOfSectionsInTableView(tableView: UITableView) -> Int
func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
*/

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var meals = [Meal]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add edit button
        navigationItem.leftBarButtonItem = editButtonItem()
        
        //Load sample meal data
        loadSampleMeals()

    }

    func loadSampleMeals() {
        
        let photo1 = UIImage(named: "bachpic")!
        let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "wheelie")!
        let meal2 = Meal(name: "Caesar Salad", photo: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "Yosemite")!
        let meal3 = Meal(name: "Dumplings", photo: photo3, rating: 4)!
        
        meals += [meal1, meal2, meal3]

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! MealTableViewCell //downcast becuase we are using a custom cell class
        
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.sourceViewController as? ViewController, meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                //update existing meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                //executes when there’s no selected row in the table view, which means a user tapped the Add button to get to the meal scene
                
                //Add a new meal
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal)
                
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "ShowDetail" {
            
            let mealDetailViewController = segue.destinationViewController as! ViewController
            
            //get the cell that generated the segue
            if let selectedMealCell = sender as? MealTableViewCell {
                
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
                
                //This code fetches the Meal object corresponding to the selected cell in the table view. It then assigns that Meal object to the meal property of the destination view controller, an instance of MealViewController
            }
            
        } else {
            if segue.identifier == "AddItem" {
                print("Adding new meal.")
            }
        }
    }
    

}
