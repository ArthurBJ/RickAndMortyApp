//
//  HomeMenuCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 19.11.2023.
//

import UIKit

final class HomeMenuCollectionViewCell: UICollectionViewCell {
    
    private let mainContrainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.layer.cornerRadius = ViewValues.defaultCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let categoryImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Images.defaultImage)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let titleCategoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView() {
        addSubview(mainContrainer)
        mainContrainer.fillSuperView(widthPadding: ViewValues.normalPadding)
        
        mainContrainer.addSubview(categoryImage)
        categoryImage.fillSuperView()
        
        configGradientForTitle()
        
        mainContrainer.addSubview(titleCategoryLabel)
        titleCategoryLabel.setConstraints(right: mainContrainer.rightAnchor,
                                          bottom: mainContrainer.bottomAnchor,
                                          left: mainContrainer.leftAnchor,
                                          pRight: ViewValues.normalPadding,
                                          pBottom: ViewValues.normalPadding,
                                          pLeft: ViewValues.normalPadding)
    }
    
    private func configGradientForTitle() {
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = self.bounds
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.darkGray.cgColor]
        gradientMaskLayer.locations = [ViewValues.gradientTitleInit, ViewValues.gradientTitleEnd]
        mainContrainer.layer.addSublayer(gradientMaskLayer)
    }
    
    func configData(viewModel: HomeMenuCollectionViewCellViewModel) {
        titleCategoryLabel.text = viewModel.title
        categoryImage.image = UIImage(named: viewModel.imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeMenuCollectionViewCell: Reusable {
    
}
