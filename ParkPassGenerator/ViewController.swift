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
        let entrant = Entrant(type: .EmployeeMaintenance)
        print("Entrant: \(entrant)\n")
        print("Areas: \(entrant.areas)")
        print("Access: \(entrant.access)")
        print("Discount: \(entrant.discount)")
        print("Requirements: \(entrant.requirements)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

