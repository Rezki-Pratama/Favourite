//
//  File.swift
//  
//
//  Created by Rezki Pratama on 08/12/22.
//

import Core
import Restaurant
 
public struct FavouriteTransformer: Mapper {
  
    public typealias Response = RestaurantResponse
    public typealias Entity = FavouriteModuleEntity
    public typealias Domain = RestaurantDomainModel
    
    public init() {}
    
    public func transformResponseToEntity(response: RestaurantResponse) -> FavouriteModuleEntity {
      fatalError()
    }
    
    public func transformEntityToDomain(entity: FavouriteModuleEntity) -> RestaurantDomainModel {
       fatalError()
    }
  
    public func transformResponseToDomain(response: RestaurantResponse) -> RestaurantDomainModel {
      fatalError()
    }
  
    public func transformDomainToEntity(domain: RestaurantDomainModel) -> FavouriteModuleEntity {
      let entities = FavouriteModuleEntity()
      entities.id = domain.id
      entities.name = domain.name
      entities.desc = domain.description
      entities.pictureId = domain.pictureId
      entities.city = domain.city
      entities.rating = domain.rating
      entities.address = domain.address
      return entities
    }
  
}
  
