//
//  ListCell.swift
//  NYTApp
//
//  Created by Baki Uçan on 11.05.2023.
//

import UIKit

class ListCell: UITableViewCell {

  static let reuseIdentifier = "ListCell"

  private let favoriteButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    button.tintColor = .systemRed
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()


  private let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 4
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    label.textColor = UIColor.black
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

  var viewModel: StoryViewModel?

  private let contentContainer: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 6
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowOpacity = 0.2
    view.layer.shadowRadius = 4
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
      contentView.addSubview(thumbnailImageView)
      contentView.addSubview(titleLabel)
      contentView.addSubview(authorLabel)
      contentView.addSubview(favoriteButton)

      NSLayoutConstraint.activate([
          thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
          thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
          thumbnailImageView.widthAnchor.constraint(equalToConstant: 60),
          thumbnailImageView.heightAnchor.constraint(equalToConstant: 60),

          favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
          favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
          favoriteButton.widthAnchor.constraint(equalToConstant: 24),
          favoriteButton.heightAnchor.constraint(equalToConstant: 24),

          titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16),
          titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
          titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8),

          authorLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16),
          authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
          authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
          authorLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
      ])
  }

  func configure(with viewModel: StoryViewModel) {
      self.viewModel = viewModel
      titleLabel.text = viewModel.title
      authorLabel.text = viewModel.author
      thumbnailImageView.setImage(from: viewModel.thumbnailURL)
      updateFavoriteButton()
    }

  private func updateFavoriteButton() {
      if let title = titleLabel.text {
          let isFavorite = FavoriteManager.shared.isFavorite(title: title)
          let favoriteButtonImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
          favoriteButton.setImage(favoriteButtonImage, for: .normal)
          favoriteButton.isHidden = favoriteButtonImage == UIImage(systemName: "heart")
      }
  }

  @objc private func favoriteButtonTapped() {
      if let title = titleLabel.text, let viewModel = self.viewModel {
        let isFavorite = FavoriteManager.shared.isFavorite(title: title)

        if isFavorite {
          FavoriteManager.shared.removeFromFavorites(title: title)
        } else {
          FavoriteManager.shared.addToFavorites(title: viewModel.title ?? "",
                                                author: viewModel.author ?? "",
                                                thumbnailURL: viewModel.thumbnailURL?.absoluteString ?? "",
                                                storyURL: viewModel.storyURL?.absoluteString ?? "")
        }

        updateFavoriteButton()
      }
    }
  }
