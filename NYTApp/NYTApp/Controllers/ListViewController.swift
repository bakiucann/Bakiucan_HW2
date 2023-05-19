//
//  ListViewController.swift
//  NYTApp
//
//  Created by Baki Uçan on 11.05.2023.
//

import UIKit
import NYTimesAPI

class ListViewController: UIViewController {
    private let listView = ListView()    // The custom view for the list screen.
    private let viewModel = ListViewModel()    // The view model for the list screen.
    private var activityIndicator: UIActivityIndicatorView?    // The activity indicator view.

    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        listView.tableView.dataSource = self
        listView.tableView.delegate = self
        setupActivityIndicator()
        fetchData()
    }

    // MARK: - Setup

    private func setupNavigationBar() {
        let logo = UIImage(named: "NYTNav")   // The logo image for the navigation bar.
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        // Disable large titles
        navigationItem.largeTitleDisplayMode = .never
    }

    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)   // Create a large activity indicator view.
        activityIndicator?.center = view.center
        activityIndicator?.hidesWhenStopped = true
        view.addSubview(activityIndicator!)
    }

    // MARK: - Data Fetching

    private func fetchData() {
        activityIndicator?.startAnimating()
        viewModel.fetchTopStories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.listView.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.activityIndicator?.stopAnimating()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfStories
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseIdentifier, for: indexPath) as! ListCell
        let storyViewModel = viewModel.storyViewModel(at: indexPath.row)
        cell.configure(with: storyViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyViewModel = viewModel.storyViewModel(at: indexPath.row)
        let detailViewController = DetailViewController(storyViewModel: storyViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)

        // Set the closure for handling favorite status changes
        detailViewController.onFavoriteStatusChanged = { [weak self] in
            self?.listView.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
