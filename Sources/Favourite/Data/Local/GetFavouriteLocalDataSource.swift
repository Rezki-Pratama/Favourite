//
//  File.swift
//
//
//  Created by Rezki Pratama on 30/11/22.
//

import Core
import Combine
import RealmSwift
import Foundation
import Restaurant
 
 

public struct GetFavouriteLocalDataSource: LocalDataSource {
    
    public typealias Request = Any
    public typealias Response = FavouriteModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
  
    public func list(search: String) -> AnyPublisher<[FavouriteModuleEntity], Error> {
      return Future<[FavouriteModuleEntity], Error> { completion in
        let restaurants: Results<FavouriteModuleEntity> = {
          _realm.objects(FavouriteModuleEntity.self)
            .sorted(byKeyPath: "name", ascending: true).filter("name LIKE %@", "*\(String(describing: search))*")
        }()
        completion(.success(restaurants.toArray(ofType: FavouriteModuleEntity.self)))
        
      }.eraseToAnyPublisher()
    }
    
    public func addAll(entities: [FavouriteModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for favourite in entities {
                        _realm.add(favourite, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
  
    public func add(entities: FavouriteModuleEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
              try _realm.write {
                _realm.add(entities, update: .all)
                completion(.success(true))
              }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<FavouriteModuleEntity, Error> {
      return Future<FavouriteModuleEntity, Error> { completion in
          let favourites = _realm.object(ofType: FavouriteModuleEntity.self, forPrimaryKey: id) ?? nil
          if favourites != nil {
            completion(.success(favourites!))
          } else {
            completion(.failure(DatabaseError.invalidInstance))
          }
      }.eraseToAnyPublisher()
    }
  
    public func update(id: Int, entity: FavouriteModuleEntity) -> AnyPublisher<Bool, Error> {
      fatalError()
    }
    
    public func delete(entities: FavouriteModuleEntity) -> AnyPublisher<Bool, Error> {
      return Future<Bool, Error> { completion in
          do {
            try _realm.write {
              _realm.delete(entities)
              completion(.success(true))
            }
          } catch {
            completion(.failure(DatabaseError.requestFailed))
          }
      }.eraseToAnyPublisher()
    }
}
