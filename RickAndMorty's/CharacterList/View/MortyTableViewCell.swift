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
    
    // MARK: - Public properties
    
    var model: CharacterSet?
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupText()
        setupUI()
    }
    
    // MARK: - Configure cell
    
    func configure(withModel model: CharacterSet?) {
        self.model = model
        mortyView.layer.cornerRadius = 10
        selectionStyle = .none
        characterNameLabel.text = model?.name
        characterStatusLabel.text = model?.status
        if let url = URL(string: model?.image ?? "") {
            characterImage.kf.indicatorType = .activity
            characterImage.kf.setImage(with: url)
        }
        else {
            characterImage.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
        }
    }
    
}
// MARK: - Extention for setup text

extension MortyTableViewCell {
    
    func setupText() {
        characterNameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        characterStatusLabel.font = UIFont.systemFont(ofSize: 22)
        characterNameLabel.textAlignment = .center
        characterStatusLabel.textAlignment = .center
    }
}
// MARK: - Extention for setup UI

extension MortyTableViewCell {
    
    func setupUI() {
        mortyView.backgroundColor = .systemGray4
        characterImage.layer.borderWidth = 2
    }
}
