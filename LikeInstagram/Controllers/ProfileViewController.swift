//
//  ProfileViewController.swift
//  LikeInstagram
//
//  Created by Iury Popov on 02.11.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var isMenuOpen = false
    
    @IBOutlet weak var slideMenuView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        slideMenuView.alpha = 0
    }
    
    
    
    @IBAction func menuButton(_ sender: UIButton) {
        isMenuOpen.toggle()
        showSlideMenu()
    }
    
    @IBAction func dismissToLoginView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func showSlideMenu() {
        if isMenuOpen {
            // показываем menu
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.slideMenuView.frame.origin.x = self.view.frame.width - 140
            }) { (finished) in
                
            }
        } else {
            // убираем menu
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.slideMenuView.frame.origin.x = 0
            }) { (finished) in
            }
        }
    }
}
