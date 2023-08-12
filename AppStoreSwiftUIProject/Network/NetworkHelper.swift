//
//  NetworkHelper.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 17/7/23.
//

import Foundation

enum APIState: Error, Equatable {
    static func == (lhs: APIState, rhs: APIState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.error, .error):
            return true
        case (.data, .data):
            return true
        default:
            return false
        }
    }
    
    case loading
    case error(Error)
    case data
    case none
}

enum APIErrorHandler: Error {
    case noData
    case noURL
    case statusCode
    case error(Error)
}

enum EntityType: String, CaseIterable, Identifiable {
    
    case all
    case movie
    case album

    var value: String {
        switch self {
        case .album:
            return "Album"
        case .movie:
            return "Movie"
        case .all:
            return "ALL"
        }
    }
    
    var id: Int {
        switch self {
        case .album:
            return 3
        case .movie:
            return 1
        case .all:
            return 0
        }

    }
}

enum MethodType: String {
    case search
    case lookup
}

protocol Requestable {
    
    var basePath: String { get }
    var entityType: String { get }
    var queryItem: [String: String] {get}
    var methodType: MethodType { get }

}

extension Requestable {
        
    var basePath: String {
        return "https://itunes.apple.com"
    }
    
    var queryItemConverter: [URLQueryItem] {
        let data = queryItem.map { key, value in
            return URLQueryItem(name: key, value: value)
        }
        return data
    }
    
    func asRequestable() -> URL? {
        guard var urlstr = URLComponents(string: basePath + "/" + methodType.rawValue) else {return nil}
        urlstr.queryItems = queryItemConverter
        return urlstr.url
    }
    
}


enum AppStoreRequest: Requestable {
    
    case album(String)
    case music(String)
    case movie(String)
    case albumSong(Int)

    
    var entityType: String {
        switch self {
        case .album:
            return EntityType.album.rawValue
        case .music:
            return EntityType.album.rawValue
        case .movie:
            return EntityType.movie.rawValue
        case .albumSong:
            return "song"
        }
    }
    
    var queryItem: [String : String] {
        var items = [String: String]()
        items["entity"] = entityType.lowercased()
        switch self {
        case .music(let term):
            items["term"] = term
        case .album(let term):
            items["term"] = term
        case .movie(let term):
            items["term"] = term
        case .albumSong(let id):
            items["id"] = "\(id)"
        }
        return items
    }
    
    var methodType: MethodType {
        switch self {
        case .albumSong:
            return .lookup
        default:
            return .search
        }
    }
    
    
}
