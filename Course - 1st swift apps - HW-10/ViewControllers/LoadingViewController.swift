//
//  LoadingViewController.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 01.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    // MARK: - Override metrhods
    override func viewDidLoad() {
        super.viewDidLoad()

        DataManager.shared.loadData {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showMain", sender: self)
            }
        }
    }
}
