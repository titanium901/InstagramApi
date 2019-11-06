//
//  LikeViewController.swift
//  LikeInstagram
//
//  Created by Iury Popov on 06.11.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit


class LikeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func likeButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "likeNotification"), object: nil)
    }
    


}
