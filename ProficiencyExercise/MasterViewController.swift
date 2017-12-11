//
//  MasterViewController.swift
//  ProficiencyExercise
//
//  Created by ajeet sharma on 11/12/17.
//  Copyright © 2017 Ajeet Sharma. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     heightForView:
     
     @prame :
     
     1. text:  text we are going to add in label.
     2. font: font we already set for label.
     
     This method will return height of view(label) for fixed width.
     
     
     */
    
    func heightForView(text:String, font:UIFont) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 90 , height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
       // label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
   

}
