//
//  BaseViewController.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/25/24.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class BaseViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){}
    func configureLayout(){}
    func configureUI(){
        view.backgroundColor = .black
    }
    
}
