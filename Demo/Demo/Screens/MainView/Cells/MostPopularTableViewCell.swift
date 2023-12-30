//
//  MostPopularTableViewCell.swift
//  Demo
//
//  Created by khawaja fahad on 30/12/2023.
//

import UIKit
import AlamofireImage

class MostPopularTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageVIewThumbnail: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthors: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    var cellViewModel: MostPopularTableViewCellModel? {
        didSet {
            updateUI()
        }
    }
    
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: Helper Methods
extension MostPopularTableViewCell {
    
    func updateUI() {
        
        guard let cellViewModel = cellViewModel else {
            return
        }
        
        labelTitle.text = cellViewModel.title
        labelAuthors.text = cellViewModel.authors
        labelDate.text = cellViewModel.date
        
        guard let url = URL(string:cellViewModel.imageURLString) else {
            return
        }
        
        imageVIewThumbnail.af.setImage(withURL: url)
    }
    
}
