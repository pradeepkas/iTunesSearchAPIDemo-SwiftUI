//
//  NetworkHandler.swift
//  AppStoreSwiftUIProject
//
//  Created by Pradeep kumar on 17/7/23.
//

import Foundation
import Combine

protocol NetworkRequestProtocol {
    func getData<T: Codable>(_ requestable: Requestable, type: T.Type) -> Future<T, APIErrorHandler>
}


final class NetworkHandler: NetworkRequestProtocol {
        
    private var cancellable = Set<AnyCancellable>()
    
    func getData<T: Codable>(_ requestable: Requestable, type: T.Type) -> Future<T, APIErrorHandler> {
        return Future { [weak self] handler in
            guard let url = requestable.asRequestable(),
                  let strongsSelf = self else {
                return handler(.failure(.noURL))
            }
            print(url)
            
            let session = URLSession.shared
            session.dataTaskPublisher(for: url)
                .tryMap { responseObj -> Data in
                    guard let resp = responseObj.response as? HTTPURLResponse,
                          (200...299) ~= resp.statusCode else {
                        throw APIErrorHandler.statusCode
                    }
                    return responseObj.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        handler(.failure(APIErrorHandler.error(error)))
                    case .finished:
                        print("finished")
                    }
                } receiveValue: { result in
                    handler(.success(result))
                }
                .store(in: &strongsSelf.cancellable)
        }
    }
    
    
//    func getDataTesting<T: Codable>(_ requestable: Requestable, type: T.Type) -> Future<T, APIErrorHandler> {
//        return Future { [weak self] handler in
//            guard let url = requestable.asRequestable(),
//                  let strongsSelf = self else {
//                return handler(.failure(.noURL))
//            }
//            print(url)
//
//            let session = URLSession.shared
//            session.dataTaskPublisher(for: url)
//                .map({ res in
//                    return res.data
//                })
//                .swichto
////                .tryMap { responseObj -> Data in
////                    guard let resp = responseObj.response as? HTTPURLResponse,
////                          (200...299) ~= resp.statusCode else {
////                        throw APIErrorHandler.statusCode
////                    }
////                    return responseObj.data
////                }
//                .decode(type: T.self, decoder: JSONDecoder())
//                .receive(on: RunLoop.main)
//                .sink { completion in
//                    switch completion {
//                    case .failure(let error):
//                        handler(.failure(APIErrorHandler.error(error)))
//                    case .finished:
//                        print("finished")
//                    }
//                } receiveValue: { result in
//                    handler(.success(result))
//                }
//                .store(in: &strongsSelf.cancellable)
//        }
//    }
}
