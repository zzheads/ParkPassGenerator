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
        
        print("Trying initialize from Fake User Input: ")
        let userInput = UserInput()
        let entrants = userInput.initializeFromInput()

        print("Successfully initialized: ")
        for i in 0..<entrants.count {
            print("\(i + 1). \(entrants[i])")
        }
        let turnstyle = RideTurnstyle()
        let kitchen = Kitchen()
        let cashRegister = CashRegister()
        entrants[0].swipe(for: turnstyle)
        entrants[1].swipe(for: kitchen)
        entrants[3].swipe(for: cashRegister)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

