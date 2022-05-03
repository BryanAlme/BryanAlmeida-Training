//
//  MovieController.swift
//  ListMovies5
//
//  Created by Bryan Andres  Almeida Flores on 03/05/2022.
//

import UIKit
import Combine
import CloudKit


protocol MovieViewControllerProtocol: AnyObject {
    var viewModel: MovieViewModelType? {get set}
}

class PrincipalViewController: UIViewController , MovieViewControllerProtocol {
    
    var viewModel: MovieViewModelType?
    private var subscribers = Set<AnyCancellable>()
    
    private lazy var  segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [" MOVIE - LIST ", " FAVOURITES "])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.sizeToFit()
        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    @objc private func handleSegmentChange(_ sender: Any){
        showSegments()
    }
    
    private func showSegments(){
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            viewModel?.showAllMovies()
            self.movieListView.reloadData()
            break
        case 1:
            viewModel?.showFavouriteMovies()
            self.movieListView.reloadData()
            break
        default:
            break
        }
    }
    
    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero , primaryAction: refreshAction)
        return refresh
    }()
    
    private lazy var refreshAction: UIAction = UIAction { [weak self] _ in
        self?.refreshData()
    }
    
    private func refreshData() {
        print("refreshData")
        viewModel?.getMovies()
    }
    
    
    private lazy var usernameView : UILabel = {
        let usernameView = UILabel()
        usernameView.textColor = .white
        usernameView.font =  UIFont.boldSystemFont(ofSize: 25)
        usernameView.textAlignment = .left
        usernameView.text = "Hello:  \((UserDefaults.standard.string(forKey: Constants.username)!)) Again!!"
        usernameView.translatesAutoresizingMaskIntoConstraints = false
        
        return usernameView
    }()
    
    private lazy var movieListView : UITableView = {
        let movieListView = UITableView()
        movieListView.dataSource = self
        movieListView.delegate = self
        movieListView.register(CustomeCell.self, forCellReuseIdentifier: CustomeCell.identifier)
        movieListView.addSubview(refreshControl)
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        return movieListView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupUI()
        setupContollers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.usernameView.text = " Welcome: \((UserDefaults.standard.string(forKey: Constants.username)!))!! "
    }
    
    private func setupUI() {
        navigationController?.navigationBar.topItem?.titleView = usernameView
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "⚙️", style: .plain, target: self, action: #selector(editUsername))
        

        view.backgroundColor = .black
        view.addSubview(segmentedControl)
        view.addSubview(searchBar)
        view.addSubview(movieListView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        segmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        movieListView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        
        segmentedControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10.0).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10.0).isActive = true
        
        searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10.0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10.0).isActive = true
        
        movieListView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10.0).isActive = true
        movieListView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10.0).isActive = true
        
        movieListView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    @objc private func editUsername(){
        let editViewController = LoginViewController()
        
        
        editViewController.modalPresentationStyle = .fullScreen
        self.present(editViewController, animated: true, completion:  nil)
    }
    
    @objc private func forgetUsername(){
        UserDefaults.standard.set(nil, forKey: Constants.username)
        viewModel?.clearFavourites()
        dismiss(animated: true)
    }
    
    private func setupViewModel(){
        let networkManager = MainNetworkManager()
        self.viewModel = MovieModel(networkManager: networkManager)
    }
    
    private func setupContollers() {
        viewModel?
            .publisherMovies
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.refreshControl.endRefreshing()
                self?.movieListView.reloadData()
                self?.showSegments()
            })
            .store(in: &subscribers)
        
        viewModel?
            .publisherImages
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.movieListView.reloadData()
            })
            .store(in: &subscribers)
        
        viewModel?.getMovies()
    }
}

extension PrincipalViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel!.search(by: searchText, onlyFavourites: segmentedControl.selectedSegmentIndex == 1)
        movieListView.reloadData()
    }
}

extension PrincipalViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.totalMovies() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row: Int = indexPath.row
        
        if let movieCell = tableView.dequeueReusableCell(withIdentifier: CustomeCell.identifier, for: indexPath) as? CustomeCell {
            var movie = MovieItem(row: row)
            
            if  let viewModel  =  self.viewModel{
                if let movieData:Moviess = viewModel.getMovie(by: row){
                    movie.title = movieData.title
                    movie.overview = movieData.overview
                    if let imageData : Data = viewModel.getImageData(by: movieData.id!) {
                        movie.imageData = imageData
                    }
                    movie.isFavourite = viewModel.isFavourite(by: movieData.id!)
                }
                
                movieCell.configure(by: movie )
                return movieCell
            } else {
                return CustomeCell()
            }
        }
        
        return UITableViewCell()
    }
    
    private func showMovieDetails(by row: Int){
        let details = MovieDetailsViewController()
        details.configure(row: row)
        details.setupViewModel(viewModel: viewModel!)
        // details.modalPresentationStyle = .fullScreen
        self.present(details, animated: true, completion: {
            self.movieListView.reloadData()
        })
        // navigationController?.pushViewController(details, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        showMovieDetails(by: indexPath.row)
        return indexPath
    }
    
}
