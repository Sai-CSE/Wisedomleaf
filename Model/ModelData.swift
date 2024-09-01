//
//  ModelData.swift
//  Wisedomleaf
//
//  Created by Sai Prakash Birudaraju on 30/08/24.
//



import Foundation


struct Movie: Codable
{
    
    let  Title : String
    let Year : String
    let imdbID : String
    let `Type` : String
    let Poster: String?
    
   
    
    
}
struct MovieResponse: Codable {
    let Search: [Movie]
}


