//
//  VideoCell.swift
//  Reels
//
//  Created by Hassan on 29/07/2022.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    static let identefire = "VideoCell"
    static let nib = UINib(nibName: identefire, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.label.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.9, height: 0.9)
        containerView.layer.shadowRadius = 7
        containerView.layer.shadowOpacity = 0.1
        
        videoImg.layer.cornerRadius = 10
        
    }
    
    func setup(model: Snippet) {
        
        videoImg.setImg(url: model.thumbnails.medium.url)
        
        let newText: String = String(model.title.replacingOccurrences(of: "Swift Design Patterns (", with: "").dropLast())
        title.text = newText
        print(model.title)
    }
    
}