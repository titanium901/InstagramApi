//
//  ProfileViewController.swift
//  LikeInstagram
//
//  Created by Iury Popov on 02.11.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var slideMenuView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var circleMenuButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var auxImageView: UIImageView!
    
    // MARK: Properties
    var isMenuOpen = false
    var isContainerOpen = false
    let isCamer = UIImagePickerController.isSourceTypeAvailable(.camera)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.frame.origin.y = view.frame.height
        
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
    @IBAction func loadPhotoProfile(_ sender: UITapGestureRecognizer) {
        print("Tap")
        takePhoto()
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
    
    func setupUI() {
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    func takePhoto() {
        let ac = UIAlertController(title: "Take Photo", message: "Where do you want to take a photo?", preferredStyle: .actionSheet)
        
        if !isCamer {
            let camera = UIAlertAction(title: "Camera not available", style: .default)
            camera.isEnabled = false
            ac.addAction(camera)
        } else {
            let cameraAv = UIAlertAction(title: "Camera", style: .default) { _ in
                let picker = UIImagePickerController()
                self.pickerChouse(picker: picker, isCamera: true)
            }
            ac.addAction(cameraAv)
        }
        
        let libary = UIAlertAction(title: "Photo Libary", style: .default) { _ in
            let picker = UIImagePickerController()
            self.pickerChouse(picker: picker, isCamera: false)
        }
        ac.addAction(libary)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    //MARK: - UIImagePickerController
    
    func pickerChouse(picker: UIImagePickerController, isCamera: Bool ) {
        if isCamera {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.editedImage] as? UIImage else { return }
        
            auxImageView.image = profileImageView.image
            profileImageView.image = image
            profileImageView.alpha = 0
            auxImageView.alpha = 1
            
            picker.dismiss(animated: true) {
                delay(seconds: 0.25) {
                    UIView.animate(withDuration: 2) {
                        self.profileImageView.alpha = 1
                        self.auxImageView.alpha = 0
                    }
                }
            }
        }
    
}
