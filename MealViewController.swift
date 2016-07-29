//
//  MealViewController.swift
//  Foodtracker
//
//  Created by Hemita Pathak on 03/06/16.
//  Copyright © 2016 InformationWorks. All rights reserved.
//

import UIKit

class MealViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    
    
    
    //MARK : Properties

    
    @IBOutlet weak var nameTextField: UITextField!
    

    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    /*
     This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new meal.
     */
    var Meal: meal?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Handle the text field's user input through delegate callbacks.
        
        nameTextField.delegate = self
        
        //Setup meals if editing an existing meal.
        if let meal = Meal {
            
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.ratings
        }
        
        //enable save button only if text field has valid meal name.
        
        checkValidMealName()
    }
    
    
    
    //MARK : UITextFieldDelegate
    
    func textFieldShouldReturn(textField : UITextField) -> Bool {
        
        //Hide keywords.
        
        textField.resignFirstResponder()
        return true
        
    }
        
        func textFieldDidBeginEditing(textField: UITextField) {
            
            // Disable the Save button while editing.
            
            saveButton.enabled = false
        
    }
    
    func checkValidMealName() {
        
        //Disable save button if text field is empty.
        
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
        
        
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        checkValidMealName()
        navigationItem.title = textField.text
       
        
    }
    
    
         // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
     
         //Dismiss the picker if user canceled.
         dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
        
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //set PhotoImageView to display selected image.
        photoImageView.image = selectedImage
        
        //Dismiss the picker
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    //MARK : Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        else {
            
            navigationController!.popViewControllerAnimated(true)

            
        }
        
    }
    
    
   
    
    // This method lets you configure a view controller before it's presented.
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let ratings = ratingControl.rating
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            
            Meal = meal(name: name, photo: photo, ratings: ratings)
            
        }
    }
    
         //MARK : Actions
    
   
    
    @IBAction func selectImageFromPhotoLIbrary(sender: UITapGestureRecognizer) {
        
        //Hide the keyword
        nameTextField.resignFirstResponder()
        
        //UIImagepickerController will let you select image from the photo library
        let imagePickerController = UIImagePickerController()
        
        //only allowed photos to be picked not taken
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    /* @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        //Hide the keyword
        nameTextField.resignFirstResponder()
        
        //UIImagepickerController will let you select image from the photo library
        let imagePickerController = UIImagePickerController()
        
        //only allowed photos to be picked not taken
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
        
        
    } */
    
    
    
    
    
    

    
}

