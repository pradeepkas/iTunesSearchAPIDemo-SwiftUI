//
//  MovieModel.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 25/7/23.
//

import Foundation

// MARK: - MovieData
struct MovieData: Codable {
    let resultCount: Int
    let results: [Movies]
}

// MARK: - Result
struct Movies: Codable {
    let wrapperType, kind: String
    let id: Int
    let artistName, trackName, trackCensoredName: String
    let trackViewURL: String
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Double?
    let trackRentalPrice, collectionHDPrice, trackHDPrice, trackHDRentalPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let trackTimeMillis: Int?
    let country, currency, primaryGenreName, contentAdvisoryRating: String?
    let shortDescription, longDescription: String?
    let artistID: Int?
    let artistViewURL: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case id = "trackId"
        case artistName, trackName, trackCensoredName
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case releaseDate, collectionExplicitness, trackExplicitness, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, shortDescription, longDescription
        case artistID = "artistId"
        case artistViewURL = "artistViewUrl"
    }
    
    static func releaseDateStr(_ releaseDate: String?) -> String {
        guard let releaseDate = releaseDate else {return ""}
        let utcISODateFormatter = ISO8601DateFormatter()

        // Printing a Date
        let date = Date()
       // print(utcISODateFormatter.string(from: date))

        // Parsing a string timestamp representing a date
        let utcDate = utcISODateFormatter.date(from: releaseDate)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        if let date = utcDate {
            return formatter.string(from: date)
        }
        return ""
    }
    
    static func getStaticMovie() -> MovieViewModel {
        let image = "https://is3-ssl.mzstatic.com/image/thumb/Video123/v4/9f/f9/e8/9ff9e804-f7f5-2a01-54a8-c476a5a884fa/pr_source.lsr/100x100bb.jpg"
        let movieList = [Movies(wrapperType: "", kind: "", id: 12, artistName: "Richard Marquand", trackName: "Star Wars: Return of the Jedi", trackCensoredName: "", trackViewURL: "", previewURL: "", artworkUrl30: "", artworkUrl60: "", artworkUrl100: image, collectionPrice: nil, trackPrice: nil, trackRentalPrice: nil, collectionHDPrice: nil, trackHDPrice: nil, trackHDRentalPrice: nil, releaseDate: "", collectionExplicitness: "", trackExplicitness: "", trackTimeMillis: 0, country: "", currency: "", primaryGenreName: "", contentAdvisoryRating: "", shortDescription: "", longDescription: "", artistID: nil, artistViewURL: "")]
        let movieVM = MovieViewModel()
        movieVM.movieList = movieList
        return movieVM
     }

    
}
