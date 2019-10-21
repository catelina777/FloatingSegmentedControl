//
//  ViewController.swift
//  Example
//
//  Created by Ryuhei Kaminishi on 2019/10/21.
//  Copyright © 2019 catelina777. All rights reserved.
//

import UIKit
import FloatingSegmentedControl

class ViewController: UIViewController {

    @IBOutlet weak var control: FloatingSegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        control.setSegments(with: [
            "Today", "Days", "Months"
        ])
        control.target = self
        control.action = #selector(update(_:))
        control.isAnimateFocusMoving = true
    }


    @objc func update(_ sender: FloatingSegmentedControl) {
        print("focused index is \(sender.focusedIndex)")
    }
}

