//
//  ViewController.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/25/24.
//

import UIKit
import SnapKit

class ViewController: BaseViewController {
    
    var nameList = ["추천도서", "추천영화", "추천드라마","비슷한 영화", "비슷한 드라마"]
    
    var movie: [[Image.Result]] = [
        [Image.Result(poster_path: "")],
        [Image.Result(poster_path: "")],
        [Image.Result(poster_path: "")],
        [Image.Result(poster_path: "")]
    ]
    var kakao: [[Image.Document]] = [[Image.Document(thumbnail: "")]]
    
    lazy var tableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        view.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.id)
        view.rowHeight = 200
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            ResponseAPI.shared.responseMovie(api: .movieImage(media: "movie", language: "ko-KR")) { data, error in
                if error != nil {
                    print("1에러남")
                } else {
                    guard let movie = data else {return}
                    self.movie[0] = movie
                }
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async {
            ResponseAPI.shared.responseMovie(api: .tvImage(media: "tv", language: "ko-KR")) { data, error in
                if error != nil {
                    print("2에러남")
                } else {
                    guard let tv = data else {return}
                    self.movie[1] = tv
                }
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async {
            ResponseAPI.shared.responseMovie(api: .movieNum(query: "777")) { data, error in
                if error != nil {
                    print("3에러남")
                } else {
                    guard let num = data else {return}
                    self.movie[2] = num
                }
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async {
            ResponseAPI.shared.responseMovie(api: .tvNum(query: "1")) { data, error in
                if error != nil {
                    print("4에러남")
                } else {
                    guard let num = data else {return}
                    self.movie[3] = num
                }
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async {
            ResponseAPI.shared.responseBook(api: .bookImage(query: "시리즈")) { data, error in
                if error != nil {
                    print("5에러남")
                } else {
                    guard let book = data else {return}
                    self.kakao[0] = book
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    override func configureUI() {
        super.configureUI()
        tableView.backgroundColor = .black
        tableView.sectionIndexBackgroundColor = .black
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.isTranslucent = false
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
        return kakao.count + movie.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.id, for: indexPath) as! MovieTableViewCell
        cell.collectionView.tag = indexPath.row
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        cell.collectionView.reloadData()
        cell.titleLabel.text = nameList[indexPath.row]
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            kakao[collectionView.tag].count
        } else if collectionView.tag == 1 {
            movie[0].count
        } else if collectionView.tag == 2 {
            movie[1].count
        } else if collectionView.tag == 3 {
            movie[2].count
        } else {
            movie[3].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as! MovieCollectionViewCell
        if collectionView.tag == 0 {
            let data = kakao[collectionView.tag]
            let ImageBook = "\(data[indexPath.item].thumbnail)"
            let url = URL(string: ImageBook)
            cell.imageView.kf.setImage(with: url)
        } else if collectionView.tag == 1 {
            let data = movie[0]
            let urlImage = "https://image.tmdb.org/t/p/w500\(data[indexPath.item].poster_path)"
            let url = URL(string: urlImage)
            cell.imageView.kf.setImage(with: url)
        } else if collectionView.tag == 2 {
            let data = movie[1]
            let urlImage = "https://image.tmdb.org/t/p/w500\(data[indexPath.item].poster_path)"
            let url = URL(string: urlImage)
            cell.imageView.kf.setImage(with: url)
        } else if collectionView.tag == 3 {
            let data = movie[2]
            let urlImage = "https://image.tmdb.org/t/p/w500\(data[indexPath.item].poster_path)"
            let url = URL(string: urlImage)
            cell.imageView.kf.setImage(with: url)
        } else {
            let data = movie[3]
            let urlImage = "https://image.tmdb.org/t/p/w500\(data[indexPath.item].poster_path)"
            let url = URL(string: urlImage)
            cell.imageView.kf.setImage(with: url)
        }
        return cell
    }
    
    
}
