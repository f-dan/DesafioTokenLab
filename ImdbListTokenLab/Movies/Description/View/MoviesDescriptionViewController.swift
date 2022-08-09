//
//  TrailerViewController.swift
//  ImdbList
//
//  Created by Danilo on 10/05/22.
//

import UIKit
import Kingfisher

class MoviesDescriptionViewController: UIViewController {
    
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbMovieDescription: UILabel!
    
    // MARK: - Properties
    var viewModel: MoviesDescriptionViewModel!
    
    // MARK: - Initializers
    init(viewModel: MoviesDescriptionViewModel){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        setupDescription()
    }
    
    func setupDescription() {
        ivPoster.kf.indicatorType = .activity
        ivPoster.kf.setImage(with: viewModel.image)
        lbTitle.text = viewModel.title
        lbYear.text = viewModel.releaseDate
        lbMovieDescription.text = viewModel.overview
    }
}
