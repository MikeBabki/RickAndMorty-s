//
//  CharacterDescription.swift
//  RickAndMorty's
//
//  Created by Макар Тюрморезов on 30.01.2023.
//

import UIKit
import Kingfisher

class CharacterDescription: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var genderDescriptLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var typeDescriptLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeView: UIView!
    
    @IBOutlet weak var speciesDescriptLabel: UILabel!
    @IBOutlet weak var speciecLabel: UILabel!
    @IBOutlet weak var speciesView: UIView!
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var idDescriptLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var statusDescriptLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var charStackView: UIStackView!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Public properties
    
    var characterAttributes: CharacterSet?
   
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupText()
        setupUI()
        loadData()
    }
}

// MARK: - Extention for text setup

extension CharacterDescription {
 
    func setupText() {
        
        nameLabel.text = characterAttributes?.name
        
        idDescriptLabel.text = "ID"
        idLabel.text = String(Int((characterAttributes?.id)!))
        
        statusDescriptLabel.text = "Status"
        statusLabel.text = characterAttributes?.status
        
        speciesDescriptLabel.text = "Species"
        speciecLabel.text = characterAttributes?.species
        
        typeDescriptLabel.text = "Type"
        if characterAttributes?.type == "" {
            typeLabel.text = "Unknown"
        } else {
            typeLabel.text = characterAttributes?.type
        }
        
        genderDescriptLabel.text = "Gender"
        genderLabel.text = characterAttributes?.gender
    }
}
    // MARK: - Extention for elements setup

extension CharacterDescription {
    
    func setupUI() {
        characterImage.layer.cornerRadius = 20
        characterImage.layer.borderWidth = 1
        idView.backgroundColor = .systemMint
        statusView.backgroundColor = .white
        speciesView.backgroundColor = .systemYellow
        typeView.backgroundColor = .systemGray2
        genderView.backgroundColor = .systemPurple
        
        idView.layer.cornerRadius = 10
        statusView.layer.cornerRadius = 10
        speciesView.layer.cornerRadius = 10
        typeView.layer.cornerRadius = 10
        genderView.layer.cornerRadius = 10
        
        idView.layer.borderWidth = 1
        statusView.layer.borderWidth = 1
        speciesView.layer.borderWidth = 1
        typeView.layer.borderWidth = 1
        genderView.layer.borderWidth = 1
        
        idDescriptLabel.font = .systemFont(ofSize: 21)
        idLabel.font = .systemFont(ofSize: 21)
        statusDescriptLabel.font = .systemFont(ofSize: 21)
        statusLabel.font = .systemFont(ofSize: 21)
        speciesDescriptLabel.font = .systemFont(ofSize: 21)
        speciecLabel.font = .systemFont(ofSize: 21)
        typeDescriptLabel.font = .systemFont(ofSize: 21)
        typeLabel.font = .systemFont(ofSize: 21)
        genderDescriptLabel.font = .systemFont(ofSize: 21)
        genderLabel.font = .systemFont(ofSize: 21)
    }
}

    // MARK: - Extention for load data

extension CharacterDescription {

    func loadData() {
        if let url = URL(string: characterAttributes?.image ?? "") {
            characterImage?.kf.indicatorType = .activity
            characterImage?.kf.setImage(with: url)
        }
        else {
            characterImage?.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
        }
    }
}
