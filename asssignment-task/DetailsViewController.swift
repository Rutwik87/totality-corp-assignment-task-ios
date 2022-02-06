//
//  DetailsViewController.swift
//  asssignment-task
//
//  Created by Rutwik Shinde on 05/02/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // IBOutlets from xib
    @IBOutlet weak var downloadBtn: UIView!
    @IBOutlet weak var cancelDownloadBtn: UIView!
    @IBOutlet weak var playBtnView: UIView!
    @IBOutlet weak var downloadProgressMiddleView: UIView!
    
    @IBOutlet weak var cancelDownloadImg: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var downloadProgressLabel: UILabel!
    @IBOutlet weak var downloadLable: UILabel!
    
    @IBOutlet weak var imageSlider: UICollectionView!
    
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var readMoreBtn: UIButton!
    
    @IBOutlet weak var downloadBtnRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewWidth: NSLayoutConstraint!
    @IBOutlet weak var downloadProgressMiddleViewWidth: NSLayoutConstraint!
    @IBOutlet weak var playBtnBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupForAnimation()
        
        imageSlider.register(ImageSliderCollectionViewCell.self, forCellWithReuseIdentifier: ImageSliderCollectionViewCell.identifier)
        imageSlider.delegate = self
        imageSlider.dataSource = self
        
        // adding tap gesture to download button view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(downloadTapped(sender:)))
        downloadBtn.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadDataAnimated()
    }
    
    // hiding views and setting alphas 0 for animation
    func setupForAnimation() {
        cancelDownloadBtn.isHidden = true
        downloadProgressLabel.isHidden = true
        
        descriptionLabel.text = "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        downloadBtn.layer.cornerRadius = downloadBtn.frame.height/2.0
        collectionViewWidth.constant = view.frame.width
        
        cancelDownloadBtn.alpha = 0
        playBtnView.alpha = 0
        descriptionLabel.alpha = 0
        readMoreBtn.alpha = 0
        crossBtn.alpha = 0
        imageSlider.alpha = 0
    }
    
    func loadDataAnimated() {
        collectionViewLeftConstraint.constant = 0
        UIView.animate(withDuration: 1) {
            self.descriptionLabel.alpha = 1
            self.readMoreBtn.alpha = 1
            self.crossBtn.alpha = 1
            self.imageSlider.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func downloadTapped(sender: UITapGestureRecognizer) {
        downloadBtnRightConstraint.constant = 70
        UIView.animate(withDuration: 1, animations: {
            self.cancelDownloadBtn.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.cancelDownloadBtn.isHidden = false
            self.downloadProgressLabel.isHidden = false
            self.downloadLable.isHidden = true
            self.downloadBtn.alpha = 0.2
            self.animateDownloading()
        })
    }
    
    func animateDownloading() {
        downloadProgressMiddleViewWidth.constant = downloadBtn.frame.width
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.cancelDownloadImg.image = UIImage(systemName: "checkmark")
            self.hideDownloadButton()
        }
    }
    
    func hideDownloadButton() {
        UIView.animate(withDuration: 1, delay: 0.5, options:.curveLinear) {
            self.cancelDownloadBtn.alpha = 0
            self.downloadBtn.alpha = 0
            self.downloadProgressLabel.alpha = 0
            self.downloadProgressMiddleView.alpha = 0
        } completion: { _ in
            self.showPlayButton()
        }
    }
    
    func showPlayButton() {
        playBtnBottomConstraint.constant = -20
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
            self.playBtnView.alpha = 1
        } completion: { _ in
            let playBtnTapped = UITapGestureRecognizer(target: self, action: #selector(self.playTapped(sender:)))
            self.playBtnView.addGestureRecognizer(playBtnTapped)
        }
    }
    
    @objc func playTapped(sender: UITapGestureRecognizer) {
        print("playTapped")
        let modalVC = CustomModalViewController()
        modalPresentationStyle = .overCurrentContext
        present(modalVC, animated: true)
    }
    
    @IBAction func crossButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}



// collection view basic setup
extension DetailsViewController: UICollectionViewDelegate {
}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageSlider.dequeueReusableCell(withReuseIdentifier: ImageSliderCollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = .lightGray
        return cell
    }
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/2 - 3, height: imageSlider.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
