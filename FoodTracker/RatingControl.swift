//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Colin Horsford on 9/18/16.
//  Copyright © 2016 Paerdegat. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    var rating = 0 {
        
        //the didSet property observer is called immediately after the property’s value is set. Here, you include a call to setNeedsLayout(), which will trigger a layout update every time the rating changes.
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5

   // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "full-star")
        let emptyStarImage = UIImage(named: "empty-star")
        
        //creates 5 buttons
        for _ in 0..<starCount {
            let button = UIButton()
            
            //You’re setting two different images for different states so you can see when the buttons have been selected. The empty star image appears when a button is unselected (.Normal state). The filled-in star image appears when the button is selected (.Selected state) and when the button is both selected and highlighted (.Selected and .Highlighted states), which occurs when a user is in the process of tapping the button.
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            
            //button.backgroundColor = UIColor.redColor()
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    //creates a for loop to add spacing between buttons
    override func layoutSubviews() {
        
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
            
            updateButtonSelectionStates()
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        
        return CGSize(width: width, height: buttonSize)
    }

    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        //print("Button tapped")
        
        //The indexOf(_:) method attempts to find the selected button in the array of buttons and to return the index at which it was found.
        //You add 1 to that index to get the corresponding rating. You need to add 1 because arrays are indexed starting with 0.
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            
            // If the index of a button is less than the rating, that button should be selected.
            //This code iterates through the button array to set the state of each button according to whether its index in the array is less than the rating. If it is, index < rating evaluates to true, which sets the button’s state to selected and makes it display the filled-in star image.
            button.selected = index < rating
        }
    }
}
