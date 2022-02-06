//
//  HomeViewController.swift
//  asssignment-task
//
//  Created by Rutwik Shinde on 03/02/22.
//

import UIKit

// code to convert hexstring directly to UIColor accepted format taken from https://stackoverflow.com/a/33397427
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

enum Colors: String {
    case orange = "#f9761b"
    case yellow = "#f8e618"
    case green = "#7cd322"
}

class HomeViewController: UIViewController {
    
    var containerView: UIView!
    var topImgView: UIView!
    var button: UIButton!
    
    override func loadView() {
        // setting up basic background view
        view = UIView()
        view.backgroundColor = .white
        
        // adding orange container
        containerView = UIView()
        containerView.backgroundColor = UIColor(hexString: Colors.orange.rawValue )
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = CGFloat(20)
        
        // adding yellow container
        topImgView = UIView()
        topImgView.backgroundColor = UIColor(hexString: Colors.yellow.rawValue )
        topImgView.translatesAutoresizingMaskIntoConstraints = false
        topImgView.layer.masksToBounds = true
        topImgView.layer.cornerRadius = CGFloat(15)
        
        // adding green button
        button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 0, y: 0, width: 10, height: 60)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: Colors.green.rawValue)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.frame.height/2.0
        
        // adding subviews to parent views
        view.addSubview(containerView)
        
        containerView.addSubview(button)
        containerView.addSubview(topImgView)
        
        addConstraints()
    }
    
    func addConstraints() {
        
        // constraints for orange container
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 25),
            containerView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -25),
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            containerView.heightAnchor.constraint(equalToConstant: 500),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // constraints for yellow container
        NSLayoutConstraint.activate([
            topImgView.leftAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leftAnchor, constant: 15),
            topImgView.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor, constant: 25),
            topImgView.widthAnchor.constraint(equalToConstant: 80),
            topImgView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // constraints for green button container
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leftAnchor, constant: 20),
            button.rightAnchor.constraint(equalTo: containerView.layoutMarginsGuide.rightAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adding tap gesture to orange container
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    // present next screen on tap with animations
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let detailsVC = DetailsViewController()
        detailsVC.transitioningDelegate = self
        present(detailsVC, animated: true, completion: nil)
    }
}

// animation delegate protocol conformance
extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(animationDuration: 1)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        nil
    }
}
