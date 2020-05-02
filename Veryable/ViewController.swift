//
//  ViewController.swift
//  Veryable
//
//  Created by Ashwath  on 4/29/20.
//  Copyright © 2020 Ashwath . All rights reserved.
//

// Import the Alamofire to make the network call to read JSON file
import UIKit
import Alamofire

//To declare the variables to reach the data in the JSON file
//Decodable : is used to make it JSON decodable
struct Details: Decodable {
   
   var id : Int
   var account_type : String
   var account_name : String
   var desc : String
   }

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    
    
// Initialize the struct
    var details = [Details]()
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
//Making the network call
//Initialize the URL to variable url
//Use guard to exit the function when condition isn't met
        guard let url = URL(string: "https://veryable-public-assets.s3.us-east-2.amazonaws.com/veryable.json") else { return }
        
//Make the network call request with the below function
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response{ (responseData) in

            guard let data = responseData.data else {return}

//Decoding the JSON file using JSONDecoder()
            do{

                self.details = try JSONDecoder().decode([Details].self, from: data)

//Printing the parsed data in the console
                for i in self.details {
                    print(i.id)
                    print(i.account_name)
                    print(i.account_type)
                    print(i.desc)
                }
            }

            catch{
                print("\(error)")
            }
            self.tableView.reloadData()

        }
    }
    
   
        
        
    
//DISPLAY IN THE TABLE VIEW
//Function to initialize the number of rows in the table

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return details.count

    }

//Function to initialize the data for each row in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell" ) as! CustomTableViewCell
        
//Displaying account name and description
        cell.label1.text = details[indexPath.row].account_name.capitalized
        cell.label2.text = details[indexPath.row].desc.capitalized

//Displaying type of payment based on the type of account
        if(details[indexPath.row].account_type == "bank"){
            cell.label3.text = "Bank Account: ACH - Same Day"
        }
        
        if(details[indexPath.row].account_type == "card"){
            cell.label3.text = "Card: Instant"
        }
        
        
        
//Displaying the icon based on the type of account
        if(details[indexPath.row].account_type == "bank")
        {
            cell.sideImage.image = UIImage(named: "bank1")
        }
        
        if(details[indexPath.row].account_type == "card")
        {
              cell.sideImage.image = UIImage(named: "card1")
        }

        return cell
    }
    
//Performing segue to the SecondViewController with the data
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetails", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  let destination = segue.destination as? SecondViewController {
            
            destination.exdetails = details[(tableView.indexPathForSelectedRow?.row)!]
        }
    }

//Performing segue back to the ViewController from SecondViewController
//on clicking DONE button. This fucntion is to avoid tangles .
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue){}
 

    }




