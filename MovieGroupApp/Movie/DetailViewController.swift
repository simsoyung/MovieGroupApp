//
//  DetailViewController.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/28/24.
//

import UIKit
import Alamofire

class DetailViewController: BaseViewController {

    static let id = "DetailViewController"
    
    let titleLabel = UILabel()
    let backPoster = UIImageView()
    let mainPoster = UIImageView()
    let overTextView = UITextView()
    let casttableview = UITableView()
    
    var contentID: Int = 0
    var contentName: String = ""
    var overView: String = ""
    
    var mainImage: String = ""
    var backImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = contentName
        overTextView.text = overView
        print(contentName)
    }
    func configure(data: Image.Result) {
        titleLabel.text = data.posterImage
    }
    
    override func configureUI() {
        super.configureUI()
    }
    override func configureLayout() {
        
    }
    override func configureHierarchy() {
        
    }

}
