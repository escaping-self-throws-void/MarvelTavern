//
//  DetailsViewController.swift
//  MarvelTavern
//
//  Created by Paul Matar on 25/12/2022.
//

import UIKit
import Combine

final class DetailsViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: createLayout())
        
        cv.register(DetailsHeaderView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: DetailsHeaderView.reuseId)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.delegate = self
        return cv
    }()
    
    private lazy var dataSource = configureDataSource()
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: DetailsViewModel
    
    init(_ viewModel: DetailsViewModel) {
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
extension DetailsViewController {
    private func initialize() {
        setupUI()
        bindViewModel()
        viewModel.getDetails()
    }
    
    private func layoutViews() {
        collectionView.place(on: view).pin(
            .leading,
            .trailing,
            .bottom(to: view.safeAreaLayoutGuide, .bottom),
            .top(to: view.safeAreaLayoutGuide, .top)
        )
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        navigationItem.title = viewModel.setTitle()
        navigationController?.navigationBar.tintColor = .init(named: C.Colors.marvelRed)
    }
    
    private func bindViewModel() {
        viewModel.sections
            .receive(on: RunLoop.main)
            .sink { [weak self] sections in
                guard let self else { return }
                
                self.dataSource.apply(self.makeSnapshot(sections),
                                      animatingDifferences: true)
            }.store(in: &cancellables)
    }
}

// MARK: - CompositionalLayout Setup
extension DetailsViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [unowned self] index, _ in
            let sectionItem = self.dataSource.snapshot().sectionIdentifiers[index]
            
            switch sectionItem {
                
            case .comics:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), padding: 0)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .absolute(200), height: .absolute(200), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.interGroupSpacing = 15
                section.contentInsets = .init(top: 0, leading: 15, bottom: 30, trailing: 15)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            case .series:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), padding: 0)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(0.4), height: .fractionalHeight(0.45), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.interGroupSpacing = 15
                section.contentInsets = .init(top: 0, leading: 15, bottom: 30, trailing: 15)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            case .events, .stories:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), padding: 0)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .absolute(160), height: .absolute(120), items: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.interGroupSpacing = 15
                section.contentInsets = .init(top: 0, leading: 15, bottom: 30, trailing: 15)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            }
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .topLeading)
    }
}

// MARK: - Diffable Data Source Setup
extension DetailsViewController {
    fileprivate typealias DetailsDataSource = UICollectionViewDiffableDataSource<DetailsSection, DetailsItem>
    fileprivate typealias DetailsSnapshot = NSDiffableDataSourceSnapshot<DetailsSection, DetailsItem>
    
    private func configureDataSource() -> DetailsDataSource {
        let cellRegistration = UICollectionView.CellRegistration<CollectionCell, DetailsItem> { cell, _, model in
            cell.configure(with: model)
        }
        
        let dataSource = DetailsDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            self.supplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
        
        return dataSource
    }
    
    private func makeSnapshot(_ sections: [DetailsSection]) -> DetailsSnapshot {
        var snapshot = DetailsSnapshot()
        
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        return snapshot
    }
    
    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        guard kind == UICollectionView.elementKindSectionHeader else { return nil }
        
        guard let header = collectionView
            .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                              withReuseIdentifier: DetailsHeaderView.reuseId,
                                              for: indexPath) as? DetailsHeaderView else {
            return nil
        }
        
        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        
        header.configure(with: section.title)
        
        return header
    }
}

// MARK: - UICollectionViewDelegate
extension DetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        guard let model = dataSource.itemIdentifier(for: indexPath) else { return }
        switch model {
        case .loading(_): break
        case .details(let detail):
            let urlDetail = detail.urls?.first(where: { $0.type == .detail })
            guard let url = urlDetail?.url else { break }
            viewModel.openWebview(url)
        }
    }
}
