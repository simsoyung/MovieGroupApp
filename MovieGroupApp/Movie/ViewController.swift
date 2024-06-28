//
//  ViewController.swift
//  MovieGroupApp
//
//  Created by 심소영 on 6/25/24.
//

import UIKit
import SnapKit
import XMLCoder

class ViewController: BaseViewController, XMLParserDelegate {
    
    var nameList = ["추천도서", "추천영화", "추천드라마","비슷한 영화", "비슷한 드라마"]
    let searchBar = UISearchBar()
    var movie: [[Image.Result]] = [
        [Image.Result(poster_path: "", id: 0)],
        [Image.Result(poster_path: "", id: 0)],
        [Image.Result(poster_path: "", id: 0)],
        [Image.Result(poster_path: "", id: 0)],
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
        callRequest(text: "소설")
    }
    override func configureUI() {
        super.configureUI()
        tableView.backgroundColor = .black
        tableView.sectionIndexBackgroundColor = .black
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.isTranslucent = false
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        searchBar.placeholder = "작품 이름을 검색하세요."
        searchBar.backgroundColor = .darkGray
    }
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
        
    }
    override func configureHierarchy() {
        searchBar.delegate = self
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    func getCurrentDateTime(){
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.dateFormat = "yyyyMMdd"
        let yesterdayStr = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let yesterday = formatter.string(from: yesterdayStr!)
        UserDefaults.standard.set(yesterday, forKey: "yesterday")
    }
    func callRequest(text: String){
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async {
            ResponseAPI.shared.responseAPI(api: .movieImage(media: "movie", language: "ko-KR"),headerStr: .movie, model: Image.Movie.self) { data, error in
                if error != nil {
                    print("1에러남")
                    group.leave()
                    return
                } else {
                    guard let movie = data else { return }
                    self.movie[0] = movie.results
                    DispatchQueue.global().async {
                        ResponseAPI.shared.responseAPI(api: .movieNum(query: "\(self.movie[0][0].id)", language: "ko-KR"),headerStr: .movie, model: Image.Movie.self) { data, error in
                                if error != nil {
                                    print("3에러남")
                                    group.leave()
                                    return
                                } else {
                                    guard let num = data else {return}
                                    self.movie[2] = num.results
                                }
                                group.leave()
                        }
                    }
                }
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async {
            ResponseAPI.shared.responseAPI(api: .movieImage(media: "tv", language: "ko-KR"),headerStr: .movie, model: Image.Movie.self) { data, error in
                if error != nil {
                    print("2에러남")
                    group.leave()
                    return
                } else {
                    guard let tv = data else {return}
                    self.movie[1] = tv.results
                    group.enter()
                    DispatchQueue.global().async {
                        ResponseAPI.shared.responseAPI(api: .tvNum(query: "\(self.movie[1][0].id)", language: "ko-KR"),headerStr: .movie, model: Image.Movie.self) { data, error in
                            if error != nil {
                                print("4에러남")
                                group.leave()
                                return
                            } else {
                                guard let num = data else {return}
                                self.movie[3] = num.results
                            }
                            group.leave()
                        }
                    }
                }
                //group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async {
            ResponseAPI.shared.responseAPI(api: .bookImage(query: text),headerStr: .book, model: Image.Book.self) { data, error in
                if error != nil {
                    print("5에러남")
                    print(self.kakao)
                    group.leave()
                    return
                } else {
                    guard let book = data else {return}
                    self.kakao[0] = book.documents
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
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
            let ImageBook = "\(data[indexPath.item].thumbnailImage)"
            let url = URL(string: ImageBook)
            cell.imageView.kf.setImage(with: url)
        } else if collectionView.tag == 1 {
            let data = movie[0]
            let urlImage = "https://image.tmdb.org/t/p/w500\(data[indexPath.item].posterImage)"
            let url = URL(string: urlImage)
            cell.imageView.kf.setImage(with: url)
        } else if collectionView.tag == 2 {
            let data = movie[1]
            let urlImage = "https://image.tmdb.org/t/p/w500\(data[indexPath.item].posterImage)"
            let url = URL(string: urlImage)
            cell.imageView.kf.setImage(with: url)
        } else if collectionView.tag == 3 {
            let data = movie[2]
            let urlImage = "https://image.tmdb.org/t/p/w500\(data[indexPath.item].posterImage)"
            let url = URL(string: urlImage)
            cell.imageView.kf.setImage(with: url)
        } else {
            let data = movie[3]
            let urlImage = "https://image.tmdb.org/t/p/w500\(data[indexPath.item].posterImage)"
            let url = URL(string: urlImage)
            cell.imageView.kf.setImage(with: url)
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return searchBar.placeholder = "1글자 이상 입력해주세요." }
        if text.count >= 1 {
            callRequest(text: searchBar.text ?? "")
            
        }
    }
}
