//
//  ListCell.swift
//  NYTApp
//
//  Created by Baki Uçan on 11.05.2023.
//

import UIKit

class ListCell: UITableViewCell {

    static let reuseIdentifier = "ListCell"

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
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

      NSLayoutConstraint.activate([
          thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
          thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
          thumbnailImageView.widthAnchor.constraint(equalToConstant: 60),
          thumbnailImageView.heightAnchor.constraint(equalToConstant: 60),

          titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16),
          titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
          titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

          authorLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16),
          authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
          authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
          authorLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
      ])
  }


    func configure(with viewModel: StoryViewModel) {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        thumbnailImageView.setImage(from: viewModel.thumbnailURL)
    }
}

