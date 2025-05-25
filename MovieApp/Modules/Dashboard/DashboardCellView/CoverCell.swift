//
//  CoverCell.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import UIKit
import SkeletonView

final class CoverCell: UICollectionViewCell {
    static let identifier = "CoverCell"

    private let coverImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.isSkeletonable = true
        return view
    }()
    
    private let coverTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .label
        label.numberOfLines = 2
        label.isSkeletonable = true
        label.linesCornerRadius = 4
        label.showAnimatedGradientSkeleton()
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        label.isSkeletonable = true
        return label
    }()
    
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isSkeletonable = true
        contentView.isSkeletonable = true
        contentView.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coverTitleLabel)
        coverTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            coverTitleLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            coverTitleLabel.trailingAnchor.constraint(equalTo: ratingLabel.trailingAnchor),
            coverTitleLabel.bottomAnchor.constraint(equalTo: ratingLabel.topAnchor, constant: -8)
        ])
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.withAlphaComponent(0.9).cgColor
        ]
        gradientLayer.locations = [0.2, 1.0]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250)
        coverImageView.layer.addSublayer(gradientLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with movie: Movie?) {
        guard let coverMovie = movie else { return }
        let voteAverage = coverMovie.voteAverage ?? 0
        
        coverTitleLabel.text = coverMovie.title
        ratingLabel.text = "⭐️ \(voteAverage)"
        
        if let url = coverMovie.backdropURL {
            loadImage(from: url, into: coverImageView)
        }
    }
}
