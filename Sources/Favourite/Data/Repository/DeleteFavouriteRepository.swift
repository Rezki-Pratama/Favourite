//
//  File.swift
//
//
//  Created by Reski Pratama on 30/11/22.
//

import Core
import Combine
 
public struct DeleteFavouriteRepository<
    FavouriteLocalDataSource: LocalDataSource> : Repository
where
    FavouriteLocalDataSource.Response == FavouriteModuleEntity {
      
    public typealias Request = FavouriteModuleEntity
    public typealias Response = Bool
    
  private let _localDataSource: FavouriteLocalDataSource
  
  public init(
      localDataSource: FavouriteLocalDataSource) {
      _localDataSource = localDataSource
  }
    
  public func execute(request: FavouriteModuleEntity?) -> AnyPublisher<Bool, Error> {
    return _localDataSource.delete(entities: request!)
      .map {
        return $0
      }.eraseToAnyPublisher()
  }
}
