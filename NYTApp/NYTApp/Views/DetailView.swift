//
//  DetailView.swift
//  NYTApp
//
//  Created by Baki Uçan on 11.05.2023.
//

import UIKit

class DetailView: UIView {

  private let viewModel: DetailViewModel

  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 20
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let authorLabel: UILabel = {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 14, weight: .light)
      label.textColor = UIColor.gray
      label.numberOfLines = 0
      label.lineBreakMode = .byTruncatingTail
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
  }()

  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  public let favoriteButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    button.tintColor = .systemRed
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()


  let seeMoreButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("See more", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .black
    button.layer.cornerRadius = 10
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()


  init(viewModel: DetailViewModel) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    backgroundColor = .systemBackground
    setupViews()
    configure(with: viewModel)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
      addSubview(scrollView)
      scrollView.addSubview(stackView)

      stackView.addArrangedSubview(imageView)
      stackView.addArrangedSubview(titleLabel)
      stackView.addArrangedSubview(authorLabel)
      stackView.addArrangedSubview(descriptionLabel)

      let spacerView = UIView() // Spacer view for pushing seeMoreButton down
      stackView.addArrangedSubview(spacerView)
      spacerView.heightAnchor.constraint(equalToConstant: 20).isActive = true

      stackView.addArrangedSubview(seeMoreButton)

      addSubview(favoriteButton)

      NSLayoutConstraint.activate([
          scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
          scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
          scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
          scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

          stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
          stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
          stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
          stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
          stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),

          imageView.heightAnchor.constraint(equalToConstant: 250),

          favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
          favoriteButton.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -26),
          favoriteButton.widthAnchor.constraint(equalToConstant: 24),
          favoriteButton.heightAnchor.constraint(equalToConstant: 24),

          seeMoreButton.heightAnchor.constraint(equalToConstant: 50),
          seeMoreButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
      ])
  }


  private func configure(with viewModel: DetailViewModel) {
    imageView.setImage(from: viewModel.largeImageURL)
    titleLabel.text = viewModel.title
    authorLabel.text = viewModel.author
    descriptionLabel.text = viewModel.description
    updateFavoriteButton()
  }

  private func updateFavoriteButton() {
    if let title = titleLabel.text {
      let isFavorite = FavoriteManager.shared.isFavorite(title: title)
      let favoriteButtonImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
      favoriteButton.setImage(favoriteButtonImage, for: .normal)
    }
  }
  @objc private func favoriteButtonTapped() {
      if let title = titleLabel.text {
          let isFavorite = FavoriteManager.shared.isFavorite(title: title)

          if isFavorite {
              FavoriteManager.shared.removeFromFavorites(title: title)
          } else {
              FavoriteManager.shared.addToFavorites(title: viewModel.title ?? "",
                                                    author: viewModel.author ?? "",
                                                    thumbnailURL: viewModel.storyURL?.absoluteString ?? "",
                                                    storyURL: viewModel.storyURL?.absoluteString ?? "")
          }

          updateFavoriteButton()
      }
  }

}
