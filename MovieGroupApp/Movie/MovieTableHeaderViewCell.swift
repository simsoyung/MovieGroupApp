//
//  MovieTableHeaderViewCell.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/27/24.
//

import UIKit
import SnapKit

class MovieTableHeaderViewCell: UITableViewHeaderFooterView {
    static let id = "MovieTableHeaderViewCell"
    let titleLabel = UILabel()
    let bottomPadding = UIView()
    
    override func prepareForReuse() {
            super.prepareForReuse()

        }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 16)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomPadding)
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.height.equalTo(15)
        }
        bottomPadding.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(10)
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(title: String){
        self.titleLabel.text = title
    }
}
