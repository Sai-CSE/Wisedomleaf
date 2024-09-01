//
//  DetailViewController.swift
//  Wisedomleaf
//
//  Created by Sai Prakash Birudaraju on 31/08/24.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    var movie: Movie?
    @IBOutlet weak var favLbl: UILabel!
    var selectedMovie: Movie?
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var IMDBID: UILabel!
    
    @IBOutlet weak var heartBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = selectedMovie {
                    updateHeartButtonState(isFavorite: checkIfFavorite(movie: movie))
                }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if let movie = selectedMovie {
                    movieTitleLabel.text = movie.Title
            posterImageView.layer.cornerRadius = 23
            posterImageView.layer.masksToBounds = true
            posterImageView.layer.borderWidth = 5
         
                    posterImageView.kf.setImage(with: URL(string: movie.Poster ?? ""))
                    releaseDateLabel.text = movie.Year
            releaseDateLabel.layer.borderWidth = 4
            IMDBID.text = movie.imdbID
            IMDBID.textColor = UIColor.label
            IMDBID.backgroundColor = UIColor.lightGray
          
            movieTitleLabel.textColor = UIColor.green
            movieTitleLabel.backgroundColor = UIColor.gray
    
            
            
                }

    }
    @IBAction func heartBtn(_ sender: UIButton) {
        
        guard let movie = selectedMovie
       else
        {
            return print("Movie Compramized")
        }
        if heartBtn.tag == 0
        {
            heartBtn.setImage(UIImage(systemName: "heart" ), for: .normal)
            heartBtn.tag = 1
            saveFavorite(movie: movie)
        }
        else{
            heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartBtn.tag = 0
            removeFavorite(movie: movie)
        }
        
    }
    private func updateHeartButtonState(isFavorite: Bool){
        if isFavorite{
            heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal);
            heartBtn.tag = 1
        }
            else
            {
                heartBtn.setImage(UIImage(systemName: "heart"), for: .normal);
                heartBtn.tag = 0
            }
        }
    
    private func checkIfFavorite(movie: Movie) -> Bool {
            let defaults = UserDefaults.standard
            if let savedFavorites = defaults.object(forKey: "favoriteMovies") as? Data {
                let decoder = JSONDecoder()
                if let loadedFavorites = try? decoder.decode([Movie].self, from: savedFavorites) {
                    return loadedFavorites.contains(where: { $0.imdbID == movie.imdbID })
                }
            }
            return false
        }
    private func saveFavorite(movie: Movie) {
            var favorites = loadFavorites()
            favorites.append(movie)
            saveFavorites(favorites: favorites)
        }
        
        private func removeFavorite(movie: Movie) {
            var favorites = loadFavorites()
            if let index = favorites.firstIndex(where: { $0.imdbID == movie.imdbID }) {
                favorites.remove(at: index)
            }
            saveFavorites(favorites: favorites)
        }
    private func loadFavorites() -> [Movie] {
            let defaults = UserDefaults.standard
            if let savedFavorites = defaults.object(forKey: "favoriteMovies") as? Data {
                let decoder = JSONDecoder()
                if let loadedFavorites = try? decoder.decode([Movie].self, from: savedFavorites) {
                    return loadedFavorites
                }
            }
            return []
        }
        
        private func saveFavorites(favorites: [Movie]) {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(favorites) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "favoriteMovies")
            }
        }
    
    }
    

