//
//  ResultTableViewController.swift
//  ImdbList
//
//  Created by Danilo on 02/05/22.
//

import UIKit
import Kingfisher

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: MoviesListViewModel!
    
    // MARK: - Initializers
    init(viewModel: MoviesListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.vcDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        setupTable()
        viewModel.fetchList()
       
    }
    
    func setupTable() {
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.fetchDescription(indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        guard let movie = viewModel.movieBy(indexPath) else { return UITableViewCell()}
        cell.setup(title: movie.title, url: movie.posterURL)
        return cell
    }
}

extension MoviesListViewController: MoviesListViewDelegate {
    func endLoading() {
        self.view?.finishLoading()
    }
    
    func onFailure(error: Error, retry: (() -> Void)?) {
        self.view?.finishLoading()
        ErrorManager.display(navigation: navigationController,
                             error: error,
                             labelError: error.localizedDescription,
                             buttonRetry: retry,
                             buttonCache: {
            self.viewModel.coreDataManager.loadCache(movie: self.viewModel.currentResult, description: self.viewModel.description)
        })
    }
    
    func loading() {
        self.view?.startLoading()
    }
    
    func onSuccess() {
        self.view?.finishLoading()
        ErrorManager.dismiss(navigation: navigationController)
        self.tableView.reloadData()
    }
}
