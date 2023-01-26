//
//  MortyTableViewCell.swift
//  RickAndMorty's
//
//  Created by Макар Тюрморезов on 26.01.2023.
//

import UIKit
import Kingfisher

class MortyTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mortyView: UIView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterStatusLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    var model: CharacterSet?
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Methods
    
    func configure(withModel model: CharacterSet?) {
        
        self.model = model
        
        characterNameLabel.text = model?.name
        characterStatusLabel.text = model?.status
        characterImage.kf.setImage(with: URL(string: model?.image ?? ""), completionHandler:  { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.characterImage.image = value.image
            case .failure(_):
                self.characterImage.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
            }
        })
    }
    
}
