//
//  SecondViewController.swift
//  Veryable
//
//  Created by Ashwath  on 4/29/20.
//  Copyright © 2020 Ashwath . All rights reserved.
//


import UIKit

class SecondViewController: UIViewController {

//Declaring the labels and image
    @IBOutlet weak var acc_type: UILabel!
    @IBOutlet weak var acc_desc: UILabel!
    @IBOutlet weak var acc_img: UIImageView!
    
//Initializing the variable exdetails to the struct Details from the ViewController
    var exdetails: Details?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
//Displaying the icon based on the type of account
        if(exdetails?.account_type == "bank"){
          
            acc_img.image = UIImage(named: "bank3")
        }
        
        if(exdetails?.account_type == "card"){
          
            acc_img.image = UIImage(named: "card3")
        }
        
//Displaying the account name and description
        acc_type.text = exdetails?.account_name
        acc_desc.text = exdetails?.desc
    
    }
    
  
}
