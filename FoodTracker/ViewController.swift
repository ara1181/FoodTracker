//
//  ViewController.swift
//  FoodTracker
//
//  Created by Colin Horsford on 9/12/16.
//  Copyright © 2016 Paerdegat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
   
    
    /*
    This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new meal.
    */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
            //enable Save button only if name is valid
            checkValidMeanName()
        
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        //disable the Save button while editing
        saveButton.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        checkValidMeanName()
        navigationItem.title = textField.text
    }
    
    func checkValidMeanName() {
        
        //disable the Save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
        
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        //dismiss the picker if the user canceled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //gets called when a user selects a photo. This method gives you a chance to do something with the image or images that a user selected from the picker
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: AnyObject) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
        
            dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //An operator (===) that tests whether two object references both refer to the same object instance.
        if saveButton === sender {
            
            let name = nameTextField.text ?? ""
            //The nil coalescing operator is used to return the value of an optional if the optional has a value, or return a default value otherwise.
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            //Set the meal to be passed to MealTableViewController after the unwind segue.
            meal = Meal(name: name, photo: photo, rating: rating)
            
        }
    }
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        //hide keyboard properly when user taps image mid-type
        nameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        
        //only allow photos to be picked, not taken
        imagePickerController.sourceType = .PhotoLibrary
        
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
//    @IBAction func setDefaultLabelText(sender: UIButton) {
//        mealNameLabel.text = "Default Text"
//    }
   
    
}


