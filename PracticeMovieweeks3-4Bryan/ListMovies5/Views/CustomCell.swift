//
//  File.swift
//  ListMovies5
//
//  Created by Bryan Andres  Almeida Flores on 03/05/2022.
//
import UIKit

class CustomeCell:UITableViewCell{
    static let identifier = "CustomeCell"
    
    let posterImageView:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "label"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let overviewLabel:UILabel = {
        let label = UILabel()
        label.text = "overview"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 6
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var favouriteLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let detailButton:UIButton = {
        let detailButton = UIButton()
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        detailButton.backgroundColor = .blue
        detailButton.setTitle("Show Details", for: .normal)
        detailButton.layer.cornerRadius = 15
        detailButton.titleLabel?.font = UIFont.systemFont(ofSize:15)
       
        
        
        return detailButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    private func setupUI(){
      
        self.contentView.addSubview(posterImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(overviewLabel)
        self.contentView.addSubview(favouriteLabel)
        self.contentView.addSubview(detailButton)
        
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            detailButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -5),
            detailButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant:-10),
            detailButton.leadingAnchor.constraint(equalTo: favouriteLabel.leadingAnchor,constant:-40),
            
            posterImageView.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 5),

            posterImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 5),
            posterImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -5),
            posterImageView.heightAnchor.constraint(equalToConstant: 230),
            posterImageView.widthAnchor.constraint(equalToConstant: 180),
            
            favouriteLabel.bottomAnchor.constraint(equalTo: detailButton.topAnchor,constant:-10),
            favouriteLabel.trailingAnchor.constraint(equalTo: detailButton.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            //titleLabel.bottomAnchor.constraint(equalTo: overviewLabel.topAnchor,constant:10),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 5),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: detailButton.leadingAnchor),
            //overviewLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
        ])
    }
    

    func configure(by movieItem: MovieItem){
        if let data = movieItem.imageData{
            posterImageView.image     = UIImage(data: data)
        }
        titleLabel.text = movieItem.title
        overviewLabel.text = movieItem.overview
        
        if(movieItem.isFavourite ?? false) {
            favouriteLabel.image =  UIImage(systemName: "star.fill")
        } else {
            favouriteLabel.image =  UIImage(systemName: "star")
        }
        
    }
}


