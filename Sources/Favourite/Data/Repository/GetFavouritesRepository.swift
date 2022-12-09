//
//  File.swift
//
//
//  Created by Reski Pratama on 30/11/22.
//

import Core
import Combine
import Restaurant
 
public struct GetFavouritesRepository<
    FavouriteLocalDataSource: LocalDataSource,
    Transformer: Mapper>: Repository
where
    FavouriteLocalDataSource.Response == FavouriteModuleEntity,
    Transformer.Response == [RestaurantResponse],
    Transformer.Entity == [FavouriteModuleEntity],
    Transformer.Domain == [RestaurantDomainModel] {
  
    public typealias Request = Any
    public typealias Response = [RestaurantDomainModel]
    
    private let _localDataSource: FavouriteLocalDataSource
    private let _mapper: Transformer
    
    public init(
        localDataSource: FavouriteLocalDataSource,
        mapper: Transformer) {
        
        _localDataSource = localDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[RestaurantDomainModel], Error> {
     return _localDataSource.list(search: request as? String ?? "")
                  .map { _mapper.transformEntityToDomain(entity: $0) }
                  .eraseToAnyPublisher()
    }
}
