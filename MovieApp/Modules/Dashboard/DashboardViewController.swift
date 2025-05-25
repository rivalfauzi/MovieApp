//
//  DashboardViewController.swift
//  MovieApp
//
//  Created by Rival Fauzi on 25/05/25.
//

import UIKit
import SkeletonView

class DashboardViewController: BaseViewController {
    private var collectionView: UICollectionView!
    
    var presenter: DashboardPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.isSkeletonable = true
        setupView()
        presenter.fetchMovieData(page: 1)
    }
    
    init(presenter: DashboardPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DashboardViewController {
    private func setupView() {
        title = "general.dashboard".localized
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let itemWidth = (view.bounds.width - spacing * 3) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.8)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isSkeletonable = true
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.register(CoverCell.self, forCellWithReuseIdentifier: CoverCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func showSkeletonAndLoadData() {
        collectionView.showAnimatedGradientSkeleton()
        collectionView.stopSkeletonAnimation()
        view.hideSkeleton()
        collectionView.reloadData()
    }
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : presenter.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoverCell.identifier, for: indexPath) as? CoverCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: presenter.coverMovie)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
                return UICollectionViewCell()
            }
            let movie = presenter.movies[indexPath.item]
            cell.configure(with: movie)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: 220)
        } else {
            let spacing: CGFloat = 16
            let itemWidth = (view.bounds.width - spacing * 3) / 2
            return CGSize(width: itemWidth, height: itemWidth * 1.8)
        }
    }
}

extension DashboardViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return MovieCell.identifier
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navigation = self.navigationController else { return }
        var selectedMovie = presenter.movies[indexPath.item]
        
        if indexPath.section == 0 {
            selectedMovie = presenter.coverMovie ?? presenter.movies[indexPath.item] 
        }
        
        presenter.navigateToDetail(from: navigation, movieId: selectedMovie.id)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if position > (contentHeight - frameHeight - 100) {
            presenter.loadNextPageIfNeeded()
        }
    }

}
