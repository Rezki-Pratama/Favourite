//
//  File.swift
//
//
//  Created by Rezki Pratama on 30/11/22.
//

import Core
import Restaurant
 
public struct FavouritesTransformer: Mapper {
  
    public typealias Response = [RestaurantResponse]
    public typealias Entity = [FavouriteModuleEntity]
    public typealias Domain = [RestaurantDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(response: [RestaurantResponse]) -> [FavouriteModuleEntity] {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: [FavouriteModuleEntity]) -> [RestaurantDomainModel] {
        return entity.map { result in
          return RestaurantDomainModel(
            id: result.id,
            name: result.name,
            pictureId: result.pictureId, description: result.desc,
            city: result.city,
            rating: result.rating,
            address: result.address,
            customerReviews: [],
            categories: [],
            menus: nil
          )
        }
    }
  
  public func transformResponseToDomain(response: [RestaurantResponse]) -> [RestaurantDomainModel] {
    fatalError()
  }
  
  public func transformDomainToEntity(domain: [RestaurantDomainModel]) -> [FavouriteModuleEntity] {
    fatalError()
  }
  
}
