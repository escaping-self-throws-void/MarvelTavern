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
        layout.sectionInset = .init(top: 0, left: 0, bottom: 15, right: 0)
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
    
    private lazy var dataSource = configureDataSource()
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: HeroesViewModel

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
        setupUI()
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
    
    private func setupUI() {
        view.backgroundColor = .black
        let logo = UIImage(named: C.Images.logo)
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    
    private func bindViewModel() {
        viewModel.heroes
            .receive(on: RunLoop.main)
            .sink { [weak self] heroes in
                guard let self else { return }
                
                self.dataSource.apply(self.makeSnapshot(heroes),
                                      animatingDifferences: true)
            }.store(in: &cancellables)
    }
}

// MARK: - Diffable Data Source Setup
extension HeroesViewController {
    fileprivate typealias HeroesDataSource = UICollectionViewDiffableDataSource<HeroSection, HeroItem>
    fileprivate typealias HeroesSnapshot = NSDiffableDataSourceSnapshot<HeroSection, HeroItem>
    
    private func configureDataSource() -> HeroesDataSource {
        let cellRegistration = UICollectionView.CellRegistration<CollectionCell, HeroItem> { cell, _, model in
            cell.configure(with: model)
        }
        
        return HeroesDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    private func makeSnapshot(_ items: [HeroItem]) -> HeroesSnapshot {
        var snapshot = HeroesSnapshot()
        snapshot.appendSections([.heroes])
        snapshot.appendItems(items, toSection: .heroes)
        return snapshot
    }
}

// MARK: - UICollectionViewDelegate
extension HeroesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        guard let model = dataSource.itemIdentifier(for: indexPath) else { return }
        switch model {
        case .loading(_): break
        case .heroes(let hero):
            guard let id = hero.id else { break }
            viewModel.openDetails(id)
        }
    }
}
