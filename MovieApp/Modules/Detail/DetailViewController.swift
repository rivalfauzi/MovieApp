//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import Foundation
import UIKit
import WebKit
import SkeletonView

class DetailViewController: BaseViewController {
    private let headerView = NavigationHeaderView()

    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()

    private let gradientLayer = CAGradientLayer()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 2
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()

    private let descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()

    private let genreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return stackView
    }()

    private let linkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("detail.homepage.button".localized, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .secondaryLabel
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["detail.info.label".localized, "detail.reviews.label".localized, "detail.trailer.label".localized])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let tabContentView = UIView()

    private let productionStackView = UIStackView()
    private let overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "detail.storyline.label".localized
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reviewsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
        table.tableFooterView = UIView()
        return table
    }()
    
    let playerView = YouTubePlayerView()

    var presenter: DetailPresenter

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    init(presenter: DetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        presenter.getMovieDetail()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @objc private func handleBack() {
        guard let navigation = self.navigationController else { return }
        presenter.backToPrevious(from: navigation)
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        updateTabContent(index: sender.selectedSegmentIndex)
    }
}

extension DetailViewController {
    func setupView() {
        view.backgroundColor = .systemBackground

        headerView.titleLabel.text = ""
        headerView.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)

        [posterImage, headerView, titleLabel, descLabel, genreStackView, linkButton, segmentedControl, tabContentView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: view.frame.height / 2.2),

            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 44),

            descLabel.bottomAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: -8),
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            titleLabel.bottomAnchor.constraint(equalTo: descLabel.topAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: descLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: descLabel.trailingAnchor),

            genreStackView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 16),
            genreStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            genreStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),

            linkButton.topAnchor.constraint(equalTo: genreStackView.bottomAnchor, constant: 12),
            linkButton.leadingAnchor.constraint(equalTo: genreStackView.leadingAnchor),
            linkButton.heightAnchor.constraint(equalToConstant: 40),
            linkButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),

            segmentedControl.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 24),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tabContentView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tabContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabContentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)

        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.withAlphaComponent(1).cgColor
        ]
        gradientLayer.locations = [0.2, 1.0]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: view.frame.height / 2.2)
        posterImage.layer.addSublayer(gradientLayer)
    }

    func updateViewData() {
        guard let data = presenter.movie else { return }
        let formatter = DateFormatter()
        let date = formatter.date(from: data.releaseDate ?? "") ?? .now

        if let url = data.backdropURL {
            loadImage(from: url, into: posterImage)
        }

        titleLabel.text = data.title

        formatter.dateFormat = "yyyy"
        let yearString = formatter.string(from: date)
        let roundedString = String(format: "%.2f", data.voteAverage ?? 0)
        descLabel.text = "\(yearString) | ⭐️ \(roundedString) | \(data.runtime ?? 0) \("detail.minutes.label".localized)"

        genreStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let genres = data.genres?.compactMap { $0.name } ?? []
        for genre in genres {
            let label = createGenreLabel(genre)
            genreStackView.addArrangedSubview(label)
        }

        linkButton.addTarget(self, action: #selector(openTrailerLink), for: .touchUpInside)
        overviewLabel.text = data.overview

        updateTabContent(index: segmentedControl.selectedSegmentIndex)
    }
    
    func updateReviewData() {
        reviewsTableView.reloadData()
    }
    
    func updateTrailerData() {
        guard let trailer = presenter.trailer, let key = trailer.key else {
            self.showNoTrailerMessage()
            return
        }
        
        DispatchQueue.main.async {
            self.playerView.loadVideo(withKey: key)
        }
    }

    @objc private func openTrailerLink() {
        guard let url = URL(string: presenter.movie?.homepage ?? "") else { return }
        UIApplication.shared.open(url)
    }

    func updateTabContent(index: Int) {
        tabContentView.subviews.forEach { $0.removeFromSuperview() }

        switch index {
        case 0:
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false

            let contentView = UIView()
            contentView.translatesAutoresizingMaskIntoConstraints = false

            tabContentView.addSubview(scrollView)
            scrollView.addSubview(contentView)

            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: tabContentView.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: tabContentView.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: tabContentView.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: tabContentView.bottomAnchor),
                
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])

            contentView.addSubview(productionStackView)
            contentView.addSubview(overviewTitleLabel)
            contentView.addSubview(overviewLabel)

            productionStackView.axis = .vertical
            productionStackView.spacing = 8
            productionStackView.translatesAutoresizingMaskIntoConstraints = false
            productionStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

            let companyTitle = UILabel()
            companyTitle.text = "detail.companies.title".localized
            companyTitle.font = .boldSystemFont(ofSize: 16)
            companyTitle.textColor = .label
            productionStackView.addArrangedSubview(companyTitle)

            presenter.movie?.productionCompanies?.forEach { company in
                let label = UILabel()
                label.text = "• \(company.name ?? "-")"
                label.font = .systemFont(ofSize: 14)
                label.textColor = .secondaryLabel
                productionStackView.addArrangedSubview(label)
            }

            NSLayoutConstraint.activate([
                productionStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                productionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                productionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                overviewTitleLabel.topAnchor.constraint(equalTo: productionStackView.bottomAnchor, constant: 24),
                overviewTitleLabel.leadingAnchor.constraint(equalTo: productionStackView.leadingAnchor),
                overviewTitleLabel.trailingAnchor.constraint(equalTo: productionStackView.trailingAnchor),

                overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 24),
                overviewLabel.leadingAnchor.constraint(equalTo: productionStackView.leadingAnchor),
                overviewLabel.trailingAnchor.constraint(equalTo: productionStackView.trailingAnchor),
                overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])

        case 1:
            tabContentView.subviews.forEach { $0.removeFromSuperview() }
            tabContentView.addSubview(reviewsTableView)
            
            reviewsTableView.delegate = self
            reviewsTableView.dataSource = self
            
            NSLayoutConstraint.activate([
                reviewsTableView.topAnchor.constraint(equalTo: tabContentView.topAnchor),
                reviewsTableView.leadingAnchor.constraint(equalTo: tabContentView.leadingAnchor, constant: 16),
                reviewsTableView.trailingAnchor.constraint(equalTo: tabContentView.trailingAnchor, constant: -16),
                reviewsTableView.bottomAnchor.constraint(equalTo: tabContentView.bottomAnchor)
            ])
            
            presenter.getReviewMovie()

        case 2:
            playerView.translatesAutoresizingMaskIntoConstraints = false
            tabContentView.addSubview(playerView)

            NSLayoutConstraint.activate([
                playerView.topAnchor.constraint(equalTo: tabContentView.topAnchor),
                playerView.leadingAnchor.constraint(equalTo: tabContentView.leadingAnchor, constant: 16),
                playerView.trailingAnchor.constraint(equalTo: tabContentView.trailingAnchor, constant: -16),
                playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9/16)
            ])
            
            presenter.getTrailerMovie()

        default: break
        }
    }
    
    private func createGenreLabel(_ text: String) -> UILabel {
        let label = PaddingLabel()
        label.text = text
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        return label
    }
    
    private func showNoTrailerMessage() {
        let label = UILabel()
        label.text = "detail.no_trailer.label".localized
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as? ReviewCell else {
            return UITableViewCell()
        }
        let review = presenter.reviews[indexPath.row]
        cell.configure(with: review)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

