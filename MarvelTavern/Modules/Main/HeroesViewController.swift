//
//  HeroesViewController.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import UIKit
import Combine

final class HeroesViewController: UIViewController {
        
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        let size = view.bounds.size
        layout.itemSize = .init(width: size.width * 0.8,
                                height: size.height * 0.35)
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        return cv
    }()
    
    private var dataSource: HeroesDataSource!
    private let viewModel: HeroesViewModel
    private var cancellables = Set<AnyCancellable>()

    init(_ viewModel: HeroesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutViews()
    }
}

// MARK: - Private methods
extension HeroesViewController {
    private func initialize() {
        view.backgroundColor = .black
        setupNavigationBar()
        configureDataSource()
        bindViewModel()
        viewModel.getHeroes()
    }
    
    private func layoutViews() {
        collectionView.place(on: view).pin(
            .leading,
            .trailing,
            .bottom(to: view.safeAreaLayoutGuide, .bottom),
            .top(to: view.safeAreaLayoutGuide, .top, padding: 15)
        )
    }
    
    private func setupNavigationBar() {
        let logo = UIImage(named: C.Images.logo)
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    private func bindViewModel() {
        viewModel.refresh
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else { return }
                
                self.dataSource.apply(
                    self.makeSnapshot(),
                    animatingDifferences: true
                )
            }.store(in: &cancellables)
    }
}

// MARK: - UICollectionViewDelegate
extension HeroesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)

    }
}


// MARK: - Diffable Data Source Setup
extension HeroesViewController {
    fileprivate typealias HeroesDataSource = UICollectionViewDiffableDataSource<HeroSection, HeroItem>
    fileprivate typealias HeroesSnapshot = NSDiffableDataSourceSnapshot<HeroSection, HeroItem>
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<HeroCell, HeroItem> { cell, _, model in
            cell.configure(with: model)
        }
        
        dataSource = HeroesDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        dataSource.apply(makeSnapshot(), animatingDifferences: false)
    }
    
    private func makeSnapshot() -> HeroesSnapshot {
        var snapshot = HeroesSnapshot()
        snapshot.appendSections([.heroes])
        
        viewModel.heroes.isEmpty
            ? snapshot.appendItems(HeroItem.loadingItems, toSection: .heroes)
            : snapshot.appendItems(viewModel.heroes.map(HeroItem.heroes), toSection: .heroes)
        
        return snapshot
    }
}
