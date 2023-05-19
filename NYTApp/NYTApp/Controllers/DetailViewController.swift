//
//  DetailViewController.swift
//  NYTApp
//
//  Created by Baki Uçan on 11.05.2023.
//

import UIKit
import NYTimesAPI
import SafariServices

class DetailViewController: UIViewController {
  private let detailView: DetailView
      private let viewModel: DetailViewModel

      init(storyViewModel: StoryViewModel) {
          self.viewModel = DetailViewModel(story: storyViewModel.story)
          self.detailView = DetailView(viewModel: viewModel)
          super.init(nibName: nil, bundle: nil)
      }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = detailView
    }

  override func viewDidLoad() {
      super.viewDidLoad()
      setupNavigationBar()
      setupSeeMoreButton()
      updateFavoriteButton()
  }

    private func setupNavigationBar() {
        title = viewModel.navigationTitle
    }

  private func updateFavoriteButton() {
      let isFavorite = FavoriteManager.shared.isFavorite(title: viewModel.title ?? "")
      let favoriteButtonImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
      detailView.favoriteButton.setImage(favoriteButtonImage, for: .normal)
  }


    private func setupSeeMoreButton() {
        detailView.seeMoreButton.addTarget(self, action: #selector(seeMoreTapped), for: .touchUpInside)
      detailView.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

    }

  var onFavoriteStatusChanged: (() -> Void)?

  @objc private func favoriteButtonTapped() {
    onFavoriteStatusChanged?()
      let isFavorite = FavoriteManager.shared.isFavorite(title: viewModel.title ?? "")

      if isFavorite {
          FavoriteManager.shared.removeFromFavorites(title: viewModel.title ?? "")
      } else {
          FavoriteManager.shared.addToFavorites(title: viewModel.title ?? "",
                                                author: viewModel.author ?? "",
                                                thumbnailURL: viewModel.storyURL?.absoluteString ?? "",
                                                storyURL: viewModel.storyURL?.absoluteString ?? "")
      }

      updateFavoriteButton()
  }

    @objc private func seeMoreTapped() {
        guard let url = viewModel.storyURL else {
            return
        }

        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
