//
//  RatingControl.swift
//  Foodtracker
//
//  Created by Hemita Pathak on 04/06/16.
//  Copyright © 2016 InformationWorks. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    //MARK : Properties
    
    var rating = 0 {
        
        didSet {
            
            setNeedsLayout()
        }
        
    }
    var ratingButtons = [UIButton]()
    let spacing = 3
    let starCount = 5
    

    //MARK : Initialization
    
    
    override func layoutSubviews() {
        
        var buttonFrame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        //Set button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
            
        }
           updateButtonSelectionStates()
    
    }
    
    
    required init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "FilledStar")
        let emptyStarImage = UIImage(named: "EmptyStar")

        
        
        for _ in 0..<starCount {
           let button = UIButton()
        //Add button to the view
        
        //button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.setImage(emptyStarImage, forState: .Normal)
        button.setImage(filledStarImage, forState: .Selected)
        button.setImage(filledStarImage, forState: [.Highlighted , .Selected])
            
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
        ratingButtons += [button]
        addSubview(button)
        
        }
        
   }
        
    
    
    override func intrinsicContentSize() -> CGSize {
        //return CGSize(width: 240, height: 44)
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount-1))
        return CGSize(width: width, height: buttonSize)
    }
    
    
    //MARK : button action
    
    func ratingButtonTapped(button : UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        updateButtonSelectionStates()
    }
    
    
    func updateButtonSelectionStates() {
        
        for(index , button) in ratingButtons.enumerate() {
            
            //If the index of a button is less than the rating, that button should be selected.
            
            button.selected = index < rating
         }
     }
    
}
