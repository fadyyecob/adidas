//
//  ProductListViewController.swift
//  adidas
//
//  Created by Fady Yecob on 01/05/2021.
//

import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel: ProductListViewModel
    
    private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, ProductListItemViewModel>()
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, ProductListItemViewModel> = {
        UICollectionViewDiffableDataSource<Section, ProductListItemViewModel>(
            collectionView: collectionView,
            cellProvider: { view, indexPath, item in
                view.dequeueConfiguredReusableCell(
                    using: self.cellRegistration,
                    for: indexPath,
                    item: item
                )
            }
        )
    }()
    
    private lazy var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, ProductListItemViewModel> = {
        UICollectionView.CellRegistration { cell, indexPath, productListItemViewModel in
            var config = cell.defaultContentConfiguration()
            UIImage.load(fromURL: productListItemViewModel.imageURL) { image in
                config.image = image?.scalePreservingAspectRatio(targetSize: .init(width: 50, height: 50))
                cell.contentConfiguration = config
            }
            config.text = productListItemViewModel.name
            config.secondaryText = productListItemViewModel.descriptionAndPrice
            
            cell.contentConfiguration = config
            cell.accessories = [.disclosureIndicator()]
        }
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(viewModel: ProductListViewModel = ProductListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        configureCollectionView()
        loadData()
        setupSearchController()
    }
    
    private func loadData() {
        viewModel.getProducts { [weak self] result in
            guard let self = self else {
                return
            }
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .success:
                self.loadCachedProducts()
            case .failure:
                let alert = UIAlertController.make(title: "Could not load products")
                self.present(alert, animated: true)
            }
        }
    }
    
    private func loadCachedProducts() {
        let filteredCachedProducts = viewModel.filteredCachedProducts(using: searchController.searchBar.text)
        
        dataSourceSnapshot.deleteAllItems()
        dataSourceSnapshot.appendSections([.main])
        dataSourceSnapshot.appendItems(filteredCachedProducts, toSection: .main)
        dataSource.apply(dataSourceSnapshot)
    }
    
    private func configureCollectionView() {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: - UICollectionViewDelegate
extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let productDetailsViewModel = viewModel.productDetailsViewModel(atRow: indexPath.row, searchText: searchController.searchBar.text) else {
            return
        }
        
        navigationController?.pushViewController(ProductDetailsViewController(viewModel: productDetailsViewModel), animated: true)
    }
    
}

// MARK: UISearchResultsUpdating
extension ProductListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    loadCachedProducts()
  }
}
