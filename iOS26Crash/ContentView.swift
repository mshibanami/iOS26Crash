//
//  ContentView.swift
//  iOS26Crash
//
//  Created by Manabu Nakazawa on 30/9/2025.
//
import SwiftUI

struct ContentView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ContentViewController {
        return ContentViewController()
    }

    func updateUIViewController(_ uiViewController: ContentViewController, context: Context) {}
}

@MainActor final class ContentViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    nonisolated enum MyViewSection: Hashable, Sendable {
        case main
    }

    private lazy var dataSource = UICollectionViewDiffableDataSource<MyViewSection, Int>(
        collectionView: collectionView,
        cellProvider: { collectionView, indexPath, item in
            collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RedirectCollectionViewCell
        }
    )

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
        super.init(collectionViewLayout: layout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(RedirectCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = dataSource
        applySnapshot()
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<MyViewSection, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems([0], toSection: .main)
        dataSource.apply(snapshot)
    }
}
