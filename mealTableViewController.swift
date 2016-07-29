//
//  mealTableViewController.swift
//  Foodtracker
//
//  Created by Hemita Pathak on 08/06/16.
//  Copyright © 2016 InformationWorks. All rights reserved.
//

import UIKit

class mealTableViewController: UITableViewController {
    
    
    
    //MARK : Properties
    
    var meals = [meal]()
    
    func loadSampleMeals () {
        
        let photo1 = UIImage(named: "meal1")!
        let meal1 = meal(name: "Italian Pizza", photo: photo1, ratings: 5)!
        
        let photo2 = UIImage(named: "meal2")!
        let meal2 = meal(name: "Pasta", photo: photo2, ratings: 4)!
        
        let photo3 = UIImage(named: "meal3")!
        let meal3 = meal(name: "Bruschetta", photo: photo3, ratings: 5)!
        
        let photo4 = UIImage(named: "meal4")!
        let meal4 = meal(name: "Caprese Salad", photo: photo4, ratings: 3)!
        
        let photo5 = UIImage(named: "meal5")!
        let meal5 = meal(name: "Capsicum Platter", photo: photo5, ratings: 5)!
                
        meals += [meal1 , meal2 , meal3 , meal4 , meal5]
        
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Use edit button item provided by table view controller.
        
    navigationItem.leftBarButtonItem = editButtonItem()
        
        //Load any saved meals, or load sample data.
        if let savedMeals = loadMeals() {
            
            meals += savedMeals
        }
        
        else{
        
        //Load sample meals.
        
        loadSampleMeals()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]

        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.ratings

        return cell
    }
    
    
    @IBAction func unwindToMealList(sender : UIStoryboardSegue) {
        
        if let sourceViewController = sender.sourceViewController as?
            MealViewController, meal = sourceViewController.Meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                //Update an existing meal.
                
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                
            }
                
                else {
                    
                    // Add new meal.
                    
                    let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                    meals.append(meal)
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                
            }
            
                   // Save the meals.
                    saveMeals()
            
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
            saveMeals()
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
            
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            
            //Get the segue that generated this segue.
            
            if let selectedMealCell = sender as? MealTableViewCell {
                
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.Meal = selectedMeal
                
             }
            
        }
        
        else if segue.identifier == "AddItem" {
            print("Adding New Item")
            
        }
        
        
    }
    
    //MARK : NACoding
    
    func saveMeals() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: meal.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            
            print("Failed to save meals...")
            
            
        }
        
    }
    
    func loadMeals() -> [meal]? {
        
        return (NSKeyedUnarchiver.unarchiveObjectWithFile(meal.ArchiveURL.path!) as? [meal])
        
    }
    
    
    
    

}
