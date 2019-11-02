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
    var isContainerOpen = false
    
    @IBOutlet weak var slideMenuView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var circleMenuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.containerView.frame.origin.y = self.view.frame.height
    }
    
    
    @IBAction func dismissToLoginView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showContainerView(_ sender: UIButton) {
        isContainerOpen.toggle()
        showContainerView()
    }
    @IBAction func menuButton(_ sender: UIButton) {
         isMenuOpen.toggle()
         showSlideMenu()
     }
    
    func showContainerView() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.containerView.frame.origin.y = self.isContainerOpen ? self.view.frame.height - self.containerView.frame.height : self.view.frame.height
                        self.circleMenuButton.transform = CGAffineTransform(rotationAngle: self.isContainerOpen ? CGFloat(Double.pi/4) : CGFloat(Double.pi * 2))
        }) { (finished) in
            
        }
    }
    
    func showSlideMenu() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.slideMenuView.frame.origin.x = self.isMenuOpen ? self.view.frame.width - 140 : 0
                        self.menuButton.transform = CGAffineTransform(rotationAngle: self.isMenuOpen ? CGFloat(Double.pi/2) : CGFloat(Double.pi * 2))
        }) { (finished) in
            
        }
    }
    
}
