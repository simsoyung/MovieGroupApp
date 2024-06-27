//
//  MovieTableViewCell.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/25/24.
//

import UIKit

class MovieTableViewCell: BaseTableViewCell {
    static let id = "MovieTableViewCell"
    
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())

    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return layout
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .black
        contentView.backgroundColor = .black
    }

}
