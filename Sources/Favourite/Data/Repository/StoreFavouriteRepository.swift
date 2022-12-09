//
//  File.swift
//
//
//  Created by Reski Pratama on 30/11/22.
//

import Core
import Combine
import Restaurant
 
public struct StoreFavouriteRepository<
    FavouriteLocalDataSource: LocalDataSource,
    Transformer: Mapper> : Repository
where
    FavouriteLocalDataSource.Response == FavouriteModuleEntity,
    Transformer.Response == RestaurantResponse,
    Transformer.Entity == FavouriteModuleEntity,
    Transformer.Domain == RestaurantDomainModel {
  
  public typealias Request = RestaurantDomainModel
  public typealias Response = Bool
    
  private let _localDataSource: FavouriteLocalDataSource
  private let _mapper: Transformer
  
  public init(
    localDataSource: FavouriteLocalDataSource, mapper: Transformer) {
      _localDataSource = localDataSource
      _mapper = mapper
  }
    
  public func execute(request: RestaurantDomainModel?) -> AnyPublisher<Bool, Error> {
    return _localDataSource.add(entities: _mapper.transformDomainToEntity(domain: request!))
      .map {
        return $0
      }.eraseToAnyPublisher()
  }
}
