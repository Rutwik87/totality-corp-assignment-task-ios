//
//  ImageSliderCollectionViewCell.swift
//  asssignment-task
//
//  Created by Rutwik Shinde on 05/02/22.
//

import UIKit

class ImageSliderCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageSliderCollectionViewCell"
    
    private let cellView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
