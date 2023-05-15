//
//  ListViewController.swift
//  NYTApp
//
//  Created by Baki Uçan on 11.05.2023.
//

import UIKit
import NYTimesAPI

class ListViewController: UIViewController {
    private let listView = ListView()
    private let viewModel = ListViewModel()

    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        listView.tableView.dataSource = self
        listView.tableView.delegate = self
        fetchData()
    }

    private func setupNavigationBar() {
        title = "Top Stories"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func fetchData() {
        viewModel.fetchTopStories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.listView.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

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

extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      let storyViewModel = viewModel.storyViewModel(at: indexPath.row)
      let detailViewController = DetailViewController(storyViewModel: storyViewModel)
      navigationController?.pushViewController(detailViewController, animated: true)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return UITableView.automaticDimension
  }
}

