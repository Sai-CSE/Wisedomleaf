//
//  ViewController.swift
//  Wisedomleaf
//
//  Created by Sai Prakash Birudaraju on 30/08/24.
//
import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var MovieArray : [Movie] = []
    var filteredMovies: [Movie] = []
    var searchingMovieNames:[String] = []
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
        myTableView?.dataSource = self
        myTableView?.delegate = self
        searchBar.delegate = self
        fetchData()
    }
    
    // By using fetching the data by Using Almofire
    func fetchData() {
        
        // Using Almofire to 
        let urlString = "https://www.omdbapi.com/?apikey=64e5c48a&type=movie&s=Don"
        AF.request(urlString, method: .get).responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let movieResponse):
                self.MovieArray = movieResponse.Search
                self.filteredMovies = self.MovieArray
                DispatchQueue.main.async {
                    self.myTableView?.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredMovies.count : MovieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! myTableViewCell
        let movie = isSearching ? filteredMovies[indexPath.row] : MovieArray[indexPath.row]
        //_ = MovieArray[indexPath.row]
       
        // Using the kingfisher to display the posters or Images
        
        if let urlString = movie.Poster, let url = URL(string: urlString) {
            cell.myImage.kf.setImage(with: url)
        } else {
            cell.myImage.image = UIImage(named: "placeholder")
        }
        cell.myImage.layer.cornerRadius = 23
        cell.myImage.isHighlighted = true
        cell.myImage.layer.masksToBounds = true;
        cell.myImage.layer.borderWidth = 3
        
        cell.myTitle.text = movie.Title
        cell.myTitle.font = UIFont(name: movie.Title, size: 5)
        cell.myTitle.layer.borderWidth = 3
        cell.myTitle.textColor = UIColor.green
        cell.myTitle.backgroundColor = UIColor.lightGray
        
       // cell.ReleaseDates.text = movie.Year
     
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0;//Choose your custom row height
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let selectedMovie = isSearching ? filteredMovies[indexPath.row] : MovieArray[indexPath.row]
        
        //  DetailViewController to show movie details
        
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier:
                                                                        "DetailViewController") as! DetailViewController;
        storyboard.selectedMovie = selectedMovie
        self.navigationController?.pushViewController(storyboard, animated:true)
        
        
    }
    //UI Searchbar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
        
            filteredMovies = MovieArray
            isSearching = false
        }
        
        else {

            filteredMovies = MovieArray.filter { Movie in
                return Movie.Title.range(of: searchText, options: .caseInsensitive) != nil
                
            }
            isSearching = true
        }
        
        myTableView.reloadData()
        
    }
    
    
}
      

