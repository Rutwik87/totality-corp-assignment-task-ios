//
//  CustomModalViewController.swift
//  asssignment-task
//
//  Created by Rutwik Shinde on 06/02/22.
//

import UIKit

class CustomModalViewController: UIViewController {

    // variable to keep track of taps on next button
    private var nextTapCount = 0
    
    @IBOutlet weak var dimmerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIView!
    @IBOutlet weak var nextButtonLabel: UILabel!
  
    @IBOutlet weak var rightAvatarRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftAvatarleftConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBarWidth: NSLayoutConstraint!
    
    @IBOutlet weak var screenOneTopBar: UIView!
    @IBOutlet weak var firstScreenView: UIView!
    @IBOutlet weak var secondScreenView: UIView!
    
    @IBOutlet weak var screenTwoTopBar: UIView!
    @IBOutlet weak var screenTwoTopBarWidth: NSLayoutConstraint!
    
    @IBOutlet weak var circlesViewLeftConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var thirdScreenView: UIView!
    @IBOutlet weak var finalScreenHeaderLabel: UILabel!
    
    
    @IBOutlet weak var finalViewCirclesLeftConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstScreenView.isHidden = true
        secondScreenView.isHidden = true
        thirdScreenView.isHidden = true
        containerHeight.constant = view.frame.height/2
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextBtnTapped(sender:)))
        nextButton.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadFirstView()
    }
    
    @objc func nextBtnTapped(sender: UITapGestureRecognizer) {
        // incrementin tap count and depending on value corresponding view is loaded
        nextTapCount += 1
        if nextTapCount == 1 {
            loadSecondView()
        } else if nextTapCount == 2 {
            loadFinalView()
        } else if nextTapCount == 3 {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func loadFirstView() {
        firstScreenView.isHidden = false
        
        self.screenOneTopBar.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        leftAvatarleftConstraint.constant = 20
        rightAvatarRightConstraint.constant = 20
       
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
            self.screenOneTopBar.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.layoutIfNeeded()
        }
    }
    
    func loadSecondView() {
        firstScreenView.isHidden = true
        secondScreenView.isHidden = false
        
        circlesViewLeftConstraint.constant = 50
        self.screenTwoTopBar.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
            self.screenTwoTopBar.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.layoutIfNeeded()
        }
    }
    
    func loadFinalView() {
        nextButton.backgroundColor = UIColor(hexString: "#292929")
        nextButtonLabel.text = "Confirm"
        secondScreenView.isHidden = true
        thirdScreenView.isHidden = false
        
        finalViewCirclesLeftConstraint.constant = 50
        finalScreenHeaderLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
            self.finalScreenHeaderLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.view.layoutIfNeeded()
        }
    }
    
}
