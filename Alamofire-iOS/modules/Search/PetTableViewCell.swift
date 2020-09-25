//
//  PetCell.swift
//  URLSession
//
//  Created by Mário Galvao on 25/09/20.
//

import UIKit

class PetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        petImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        petImageView.layer.cornerRadius = petImageView.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPet(_ pet: Pet) {
        titleLabel.text = pet.name
        subtitleLabel.text = pet.status?.rawValue
        if let path = pet.photoUrls.first, let url = URL(string: path), let data = try? Data(contentsOf: url) {
            petImageView.image = UIImage(data: data)
        } else {
            petImageView.image = #imageLiteral(resourceName: "dog.jpg")
        }
    }

}
