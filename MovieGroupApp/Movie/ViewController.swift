//
//  ViewController.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/25/24.
//

import UIKit

class ViewController: BaseViewController {
    
    var movie: [[Image.Result]] = [
        [Image.Result(poster_path: "")],
        [Image.Result(poster_path: "")]
    ]
    var kakao: [[Image.Document]] = [[Image.Document(thumbnail: "")]]
    
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.id)
        view.rowHeight = 150
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            ResponseAPI.shared.responseMovie { data in
                self.movie[0] = data
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async {
            ResponseAPI.shared.responseMovieIdNum { data in
                self.movie[1] = data
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async {
            ResponseAPI.shared.responseBook { data in
                self.kakao[0] = data
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
        
        
    }
    override func configureUI() {
        super.configureUI()
    }
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count + kakao.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.id, for: indexPath) as! MovieTableViewCell
        cell.collectionView.tag = indexPath.row
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        cell.collectionView.reloadData()
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return kakao[0].count
        } else if collectionView.tag == 1 {
            return movie[0].count
        } else {
            return movie[1].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as! MovieCollectionViewCell
        if collectionView.tag == 0 {
            let data = kakao[collectionView.tag]
            let urlImage = "\(data[indexPath.item].thumbnail)"
            let url = URL(string: urlImage)
            cell.imageView.kf.setImage(with: url)
        } else if collectionView.tag == 1 {
            let data = movie[0]
            let urlImage = "https://image.tmdb.org/t/p/w500\(data[indexPath.item].poster_path)"
            let url = URL(string: urlImage)
            cell.imageView.kf.setImage(with: url)
        } else {
            let data = movie[1]
            let urlImage = "https://image.tmdb.org/t/p/w500\(data[indexPath.item].poster_path)"
            let url = URL(string: urlImage)
            cell.imageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    
}
