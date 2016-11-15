//
//  ViewController.swift
//  ParkPassGenerator
//
//  Created by Alexey Papin on 15.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        do {
//            let entrant = try Entrant(type: .GuestChild, firstName: "John", lastName: "Doe", streetAddress: "Bellevare Street", city: "Montreal", state: "CA", zipCode: "400005", dateOfBirth: Date())
//            print("Entrant: \(entrant)\n")
//            print("Areas: \(entrant.areas)")
//            print("Access: \(entrant.access)")
//            print("Discount: \(entrant.discount)")
//            print("Requirements: \(entrant.requirements)")
//        } catch let error {
//            if error is EntrantError {
//                let error = error as! EntrantError
//                print("Required \(error.rawValue) did not provided. Please enter \(error.rawValue).")
//            } else {
//                fatalError("\(error)")
//            }
//        }
        
        
        print("Trying initialize from Fake User Input: ")
        let userInput = UserInput()
        let entrants = userInput.initializeFromInput()

        print("Successfully initialized: ")
        for i in 0..<entrants.count {
            print("\(i + 1). \(entrants[i])")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

