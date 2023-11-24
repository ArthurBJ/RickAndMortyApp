//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import UIKit
import Combine

protocol CharacterDetailViewControllerCoordinator {
    func didTapOriginButton()
    func didTapLocationButton()
}

class CharacterDetailViewController: UIViewController {
    
    private var cancellable = Set<AnyCancellable>()
    private let viewModel: CharacterDetailViewModel
    private let coordinator: CharacterDetailViewControllerCoordinator
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.addDefaultImage()
        imageView.contentMode = .scaleAspectFill
        imageView.setHeightConstraint(with: UIScreen.main.bounds.width)
        
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = ViewValues.defaultCornerRadius * 2
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name here"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var statusLabel: UILabel = makeGrayLabels(text: "Status: Alive")
    private lazy var specieLabel: UILabel = makeGrayLabels(text: "Specie: Alien")
    private lazy var genderLabel: UILabel = makeGrayLabels(text: "Gender: Male")
    
    private lazy var originButton: UIButton = makeTitleSubtitleBlueButton(title: "Origin", subtitle: "Earth (C-137)")
    private lazy var locationButton: UIButton = makeTitleSubtitleBlueButton(title: "Location", subtitle: "Citadel of Ricks")

    init(viewModel: CharacterDetailViewModel, coordinator: CharacterDetailViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        stateController()
        configTarget()
        viewModel.viewDidLoad()
    }
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(characterImageView)
        characterImageView.setConstraints(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, left: view.leftAnchor)
        
        view.addSubview(containerView)
        containerView.setConstraints(top: characterImageView.bottomAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, pTop: ViewValues.containerDetailPadding)
        
        containerView.addSubview(nameLabel)
        nameLabel.setConstraints(
            top: containerView.topAnchor,
            right: containerView.rightAnchor,
            left: containerView.leftAnchor,
            pTop: ViewValues.normalPadding)
        
        containerView.addSubview(statusLabel)
        statusLabel.setConstraints(
            top: nameLabel.bottomAnchor,
            right: containerView.rightAnchor,
            left: containerView.leftAnchor,
            pTop: ViewValues.smallPadding)
        
        containerView.addSubview(specieLabel)
        specieLabel.setConstraints(
            top: statusLabel.bottomAnchor,
            right: containerView.rightAnchor,
            left: containerView.leftAnchor,
            pTop: ViewValues.smallPadding)
        
        containerView.addSubview(genderLabel)
        genderLabel.setConstraints(
            top: specieLabel.bottomAnchor,
            right: containerView.rightAnchor,
            left: containerView.leftAnchor,
            pTop: ViewValues.smallPadding)
        
        let buttonStackView = UIStackView(arrangedSubviews: [originButton, locationButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        containerView.addSubview(buttonStackView)
        buttonStackView.setConstraints(
            top: genderLabel.bottomAnchor,
            right: containerView.rightAnchor,
            left: containerView.leftAnchor,
            pTop: ViewValues.normalPadding,
            pRight: ViewValues.doublePadding,
            pLeft: ViewValues.doublePadding)
    }
    
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
                switch state {
                case .success:
                    self?.configData()
                case .loading:
                    self?.showSpinner()
                case .fail(error: let error):
                    self?.presentAlert(message: error, title: "Error")
                }
            }
            .store(in: &cancellable)
    }
    
    private func configData() {
        nameLabel.text = viewModel.nameCharacter
        statusLabel.text = viewModel.status
        specieLabel.text = viewModel.specie
        characterImageView.setImageFromData(data: viewModel.imageData)
        originButton.configuration?.subtitle = viewModel.origin
        locationButton.configuration?.subtitle = viewModel.location
    }
    
    private func configTarget() {
        originButton.addTarget(self, action: #selector(didTapOriginButton), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(didTapLocationButton), for: .touchUpInside)
    }
    
    private func makeGrayLabels(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        return label
    }
    
    private func makeTitleSubtitleBlueButton(title: String, subtitle: String) -> UIButton {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.subtitle = subtitle
        configuration.buttonSize = .small
        configuration.titleAlignment = .center
        configuration.cornerStyle = .large
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
        })
        
        configuration.subtitleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .subheadline)
            return outgoing
        })
        
        button.configuration = configuration
        return button
    }
    
    @objc func didTapOriginButton() {
        coordinator.didTapOriginButton()
    }
    
    @objc func didTapLocationButton() {
        coordinator.didTapLocationButton()
    }
}

extension CharacterDetailViewController: SpinnerDisplayable { }

extension CharacterDetailViewController: MessageDisplayable { }
