//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Sahan Walpita on 2023-03-13.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {
    
    private var viewModel: RMCharacterDetailViewViewModel
    
    private var characterDetailView: RMCharacterDetailView
    
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.characterDetailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) is not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(characterDetailView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
        addConstraints()
        
        characterDetailView.collectionView?.delegate = self
        characterDetailView.collectionView?.dataSource = self
    }
    
    @objc
    private func didTapShare() {
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            characterDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}

// You can also make the controller a delegate instead of the viewModel
extension RMCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
            case .photo:
                return 1
            case .information(let viewModels):
                return viewModels.count
            case .episodes(let viewModels):
                return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
            case .photo(let viewModel):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier,
                    for: indexPath
                ) as? RMCharacterPhotoCollectionViewCell else {
                    fatalError()
                }
                cell.configure(with: viewModel)
                return cell
            case .information(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier,
                    for: indexPath
                ) as? RMCharacterInfoCollectionViewCell else {
                    fatalError()
                }
                cell.configure(with: viewModels[indexPath.row])
                return cell
            case .episodes(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
                    for: indexPath
                ) as? RMCharacterEpisodeCollectionViewCell else {
                    fatalError()
                }
                cell.configure(with: viewModels[indexPath.row])
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
            case .photo, .information:
                break
            case .episodes(_):
                let episodes = self.viewModel.episodes
                let selection = episodes[indexPath.row]
                let vc = RMEpisodeDetailViewController(url: URL(string: selection))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
