//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 20.11.2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    private let mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.setHeightConstraint(with: ViewValues.defaultHeightContainerCell)
        view.layer.cornerRadius = ViewValues.defaultCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let characterImageView: UIImageView = {
        let view = UIImageView()
        view.setWidthConstraint(with: ViewValues.defaultHeightContainerCell)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var labelContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.textColor = .systemBlue
        label.text = "Rick"
        return label
    }()
    
    private let specieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.text = "Human"
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.text = "🟢"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    private var task: Task<Void, Never>?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
    }
    
    private func setupView() {
        selectionStyle = .none
        
        addSubview(mainContainerView)
        
        mainContainerView.setConstraints(top: topAnchor,
                                         right: rightAnchor,
                                         bottom: bottomAnchor,
                                         left: leftAnchor,
                                         pRight: ViewValues.doublePadding,
                                         pBottom: ViewValues.doublePadding,
                                         pLeft: ViewValues.doublePadding)
        
        mainContainerView.addSubview(characterImageView)
        characterImageView.setConstraints(top: mainContainerView.topAnchor,
                                          bottom: mainContainerView.bottomAnchor,
                                          left: mainContainerView.leftAnchor)
        
        mainContainerView.addSubview(labelContainerStackView)
        labelContainerStackView.setConstraints(top: mainContainerView.topAnchor,
                                               right: mainContainerView.rightAnchor,
                                               bottom: mainContainerView.bottomAnchor,
                                               left: characterImageView.rightAnchor,
                                               pTop: ViewValues.normalPadding,
                                               pBottom: ViewValues.normalPadding,
                                               pLeft: ViewValues.normalPadding)
        
        [nameLabel, specieLabel, statusLabel].forEach {
            labelContainerStackView.addArrangedSubview($0)
        }
    }
    
    func configData(viewModel: CharacterTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        specieLabel.text = viewModel.specie
        statusLabel.text = viewModel.status
        setImage(viewModel: viewModel)
    }
    
    private func setImage(viewModel: CharacterTableViewCellViewModel) {
        characterImageView.addDefaultImage()
        if let data = viewModel.imageData {
            characterImageView.setImageFromData(data: data)
        } else {
            task = Task {
                let dataImage = await viewModel.getImageData()
                characterImageView.setImageFromData(data: dataImage)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterTableViewCell: Reusable {}
