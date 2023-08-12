//
//  AlbumModel.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 17/7/23.
//

import Foundation



// MARK: - AlbumData
struct AlbumData: Codable {
    let resultCount: Int
    let tracks: [Album]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case tracks = "results"
    }
    
}

// MARK: - Result
struct Album: Codable, Identifiable, Hashable {
    let wrapperType: String
    let collectionType: String
    let artistID: Int
    let id: Int
    let artistName, collectionName, collectionCensoredName: String
    let artworkUrl60, artworkUrl100: String
    
    let amgArtistID: Int?
    let artistViewURL, collectionViewURL: String?
    let collectionPrice: Double?
    let trackCount: Int
    let releaseDate: String
    let primaryGenreName: String
    //    let copyright: String
    //    let country: String
    //    let currency: String
    // let contentAdvisoryRating: String?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType, collectionType
        case artistID = "artistId"
        case id = "collectionId"
        case artistName, collectionName, collectionCensoredName
        case collectionPrice
        case amgArtistID = "amgArtistId"
        case artworkUrl60, artworkUrl100
        
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackCount
        case releaseDate, primaryGenreName
        //        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, copyright, country, currency, releaseDate, primaryGenreName
    }
    
   static func getStaticAlbum() -> AlbumViewModel {
       let image = "https://is4-ssl.mzstatic.com/image/thumb/Music112/v4/76/5d/55/765d554e-e421-0299-783f-d78ad559d5e5/5021392959191.png/100x100bb.jpg"
            
        let albumList = [
            Album(wrapperType: "", collectionType: "", artistID: 1, id: 1, artistName: "xyz", collectionName: "collection", collectionCensoredName: "", artworkUrl60: "", artworkUrl100: image, amgArtistID: 1, artistViewURL: "", collectionViewURL: "", collectionPrice: 0, trackCount: 10, releaseDate: "2015-02-17T08:00:00Z", primaryGenreName: "Soundtrack"),
                         
            Album(wrapperType: "", collectionType: "", artistID: 1, id: 2, artistName: "xyz", collectionName: "collection collection collection", collectionCensoredName: "", artworkUrl60: "", artworkUrl100: image, amgArtistID: 1, artistViewURL: "", collectionViewURL: "", collectionPrice: 0,trackCount: 11, releaseDate: "2015-02-17T08:00:00Z", primaryGenreName: "Soundtrack")]
       let albumView = AlbumViewModel()
       albumView.albumList = albumList
       
       return albumView

    }
    
}

extension String {
    
    func releaseDateStr() -> String {
        let utcISODateFormatter = ISO8601DateFormatter()

        // Printing a Date
        let date = Date()
       // print(utcISODateFormatter.string(from: date))

        // Parsing a string timestamp representing a date
        let utcDate = utcISODateFormatter.date(from: self)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        if let date = utcDate {
            return formatter.string(from: date)
        }
        return ""
    }

}
