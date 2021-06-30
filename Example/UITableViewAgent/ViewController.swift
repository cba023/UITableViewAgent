//
//  ViewController.swift
//  UITableViewAgent
//
//  Created by cba023@hotmail.com on 06/30/2021.
//  Copyright (c) 2021 cba023@hotmail.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = ListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

