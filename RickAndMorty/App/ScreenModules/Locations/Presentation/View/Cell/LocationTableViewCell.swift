//
//  LocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import UIKit

final class LocationTableViewCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = makeLabel(forTextStyle: .headline)
    private lazy var dimensionLabel: UILabel = makeLabel(forTextStyle: .subheadline)
    private lazy var typeLabel: UILabel = makeLabel(forTextStyle: .footnote)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    private func configUI() {
        selectionStyle = .none
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, dimensionLabel, typeLabel])
        stack.axis = .vertical
        stack.spacing = ViewValues.smallPadding
        addSubview(stack)
        stack.setConstraints(top: topAnchor,
                             right: rightAnchor,
                             bottom: bottomAnchor,
                             left: leftAnchor,
                             pTop: ViewValues.normalPadding,
                             pRight: ViewValues.normalPadding,
                             pBottom: ViewValues.normalPadding,
                             pLeft: ViewValues.doublePadding)
    }
    
    func configData(viewModel: LocationTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        dimensionLabel.text = viewModel.dimension
        typeLabel.text = viewModel.type
    }
    
    private func makeLabel(forTextStyle textStyle: UIFont.TextStyle) -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: textStyle)
        return label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LocationTableViewCell: Reusable { }
