//
//  DetailViewController.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/28/24.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class DetailViewController: BaseViewController {

    static let id = "DetailViewController"
    
    var TMDBList: Image.Result? = Image.Result(poster_path: "", id: 0, name: "", overview: "", title: "", backdrop_path: "")
    var bookList: Image.Document? = Image.Document(thumbnail: "", contents: "")
    
    var textViewHeightConstraint: Constraint?
    
    let toggleButton = UIButton()
    let titleLabel = UILabel()
    let backPoster = UIImageView()
    let mainPoster = UIImageView()
    let overTextView = UITextView()
    let casttableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backPoster.imageViewSetting()
        mainPoster.imageViewSetting()
        overTextView.overview()
        casttableview.backgroundColor = .brown
        toggleButton.addTarget(self, action: #selector(toggleTextView), for: .touchUpInside)
    }

    override func configureUI() {
        super.configureUI()
        titleLabel.text = TMDBList?.name ?? TMDBList?.title
        titleLabel.nameLabel()
        toggleButton.overviewButton()
        let urlImage = "\(TMDBList?.backdropImage ?? bookList?.thumbnailImage ?? Image.emptyImage)"
        let url = URL(string: urlImage)
        backPoster.kf.setImage(with: url)
        let mainImage = "\(TMDBList?.posterImage ?? bookList?.thumbnailImage ?? Image.emptyImage)"
        let mainurl = URL(string: mainImage)
        mainPoster.kf.setImage(with: mainurl)
        overTextView.text = "\(TMDBList?.overview ?? bookList?.contents ?? "준비중입니다.")"

    }
    override func configureLayout() {
        backPoster.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(200)
        }
        mainPoster.snp.makeConstraints { make in
            make.top.equalTo(backPoster.snp.top).inset(20)
            make.leading.equalTo(backPoster.snp.leading).inset(20)
            make.width.equalTo(120)
            make.bottom.equalTo(backPoster.snp.bottom).inset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backPoster.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
        }
        overTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            textViewHeightConstraint = make.height.equalTo(150).constraint
        }
        toggleButton.snp.makeConstraints { make in
            make.top.equalTo(overTextView.snp.bottom).inset(30)
            make.centerX.equalTo(view)
        }
        casttableview.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(overTextView.snp.bottom).offset(10)
        }
    }
    override func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(backPoster)
        view.addSubview(mainPoster)
        view.addSubview(overTextView)
        view.addSubview(casttableview)
        view.addSubview(toggleButton)
    }

    @objc func toggleTextView(){
        let isExpanded = textViewHeightConstraint?.layoutConstraints.first?.constant == 50
        
        textViewHeightConstraint?.update(offset: isExpanded ? 100 : 200)
        toggleButton.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }

    }
}
