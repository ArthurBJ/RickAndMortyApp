//
//  EpisodesTableViewCell.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import UIKit

final class EpisodesTableViewCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var numberEpisodeLabel: UILabel = makeCustomPaddingLabel()
    private lazy var dateLabel: UILabel = makeCustomPaddingLabel()
    private lazy var seasonAndEpisodeLabel: UILabel = makeCustomPaddingLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    func configData(viewModel: EpisodesTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        numberEpisodeLabel.text = viewModel.numberEpisode
        dateLabel.text = viewModel.date
        seasonAndEpisodeLabel.text = viewModel.seasonAndEpisode
    }
    
    private func configUI() {
        let containerTagsStackView = UIStackView(arrangedSubviews: [numberEpisodeLabel, dateLabel, seasonAndEpisodeLabel, UIView()])
        containerTagsStackView.axis = .horizontal
        containerTagsStackView.spacing = 4
        
        let mainContainerStackView = UIStackView(arrangedSubviews: [nameLabel, containerTagsStackView])
        mainContainerStackView.axis = .vertical
        mainContainerStackView.spacing = 5
        
        addSubview(mainContainerStackView)
        
        mainContainerStackView.setConstraints(
                    top: topAnchor,
                    right: rightAnchor,
                    bottom: bottomAnchor,
                    left: leftAnchor,
                    pTop: 10,
                    pRight: 10,
                    pBottom: 10,
                    pLeft: 20)
        
    }
    
    private func makeCustomPaddingLabel() -> UILabel {
        let label = CustomPaddingLabel()
        label.backgroundColor = .systemBlue
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.edgeInset = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textColor = .white
        return label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EpisodesTableViewCell: Reusable { }
