//
//  AlbuamCollectionViewCell.swift
//  bostaTask
//
//  Created by Mahmoud on 03/03/2023.
//

import UIKit
import Kingfisher
class AlbuamCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configImage(url : String)
    {
        imageCell.kf.setImage(with: URL(string: url),placeholder:UIImage(named: "notFound"))
    }
}
