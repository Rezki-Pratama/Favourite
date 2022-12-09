//
//  File.swift
//
//
//  Created by Reski Pratama on 30/11/22.
//

import Core
import Combine
import Restaurant
 
public struct GetFavouriteRepository<
    FavouriteLocalDataSource: LocalDataSource> : Repository
where
    FavouriteLocalDataSource.Response == FavouriteModuleEntity {
  
    public typealias Request = String
    public typealias Response = FavouriteModuleEntity
    
    private let _localDataSource: FavouriteLocalDataSource
    
    public init(
        localDataSource: FavouriteLocalDataSource) {
        
        _localDataSource = localDataSource
    }
    
    public func execute(request: String?) -> AnyPublisher<FavouriteModuleEntity, Error> {
      return _localDataSource.get(id: request!).eraseToAnyPublisher()
    }
}
