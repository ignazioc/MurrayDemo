//
//  ViewController.swift
//  EBKUI
//
//  Created by Ignazio Calò on 04/24/2019.
//  Copyright (c) 2019 Ignazio Calò. All rights reserved.
//

import EBKUI
import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let c = EBKContainerWithShadow(frame: CGRect(x: 50, y: 100, width: 300, height: 150))
        view.addSubview(c)

        let buttonWithChevron = EBKButtonWithChevron(frame: CGRect(x: 50, y: 300, width: 300, height: 150))
        buttonWithChevron.setTitle("click me", for: .normal)
        view.addSubview(buttonWithChevron)
    }
}
