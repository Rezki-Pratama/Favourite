//
//  File.swift
//  
//
//  Created by Rezki Pratama on 07/12/22.
//

import Foundation
import Combine
import Core
import Restaurant
import SwiftUI

public class FavouritesPresenter<
  StoreUseCase: UseCase,
  GetUseCase: UseCase,
  GetByIdUseCase: UseCase,
  DeleteUseCase: UseCase
>: ObservableObject where
  StoreUseCase.Request == RestaurantDomainModel,
  StoreUseCase.Response == Bool,
  GetUseCase.Request == Any,
  GetUseCase.Response == [RestaurantDomainModel],
  GetByIdUseCase.Request == String,
  GetByIdUseCase.Response == FavouriteModuleEntity,
  DeleteUseCase.Request == FavouriteModuleEntity,
  DeleteUseCase.Response == Bool
{

  private var cancellables: Set<AnyCancellable> = []
  
  private let storeUseCase: StoreUseCase
  private let getUseCase: GetUseCase
  private let getbyIdUseCase: GetByIdUseCase
  private let deleteUseCase: DeleteUseCase
  

  @Published public var list: GetUseCase.Response = []
  @Published public var errorMessage: String = ""
  @Published public var search: String = String()
  @Published public var resourceState: ResourceState = .initial
  @Published public var favouriteData: FavouriteModuleEntity?
  
  @Published public var isFavourite: Bool = false

  public init(
    storeUseCase: StoreUseCase,
    getUseCase: GetUseCase,
    getbyIdUseCase: GetByIdUseCase,
    deleteUseCase: DeleteUseCase
  ) {
    self.storeUseCase = storeUseCase
    self.getUseCase = getUseCase
    self.getbyIdUseCase = getbyIdUseCase
    self.deleteUseCase = deleteUseCase
  }

  public func getFavourites() {
    self.resourceState = .loading
    getUseCase.execute(request: nil)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.resourceState = .error
            self.errorMessage = String(describing: completion)
          case .finished:
            print("Finish")
          }
        }, receiveValue: { list in
          print(list)
          if list.isEmpty {
            self.resourceState = .empty
          } else {
            self.resourceState = .success
            self.list = list
          }
        })
        .store(in: &cancellables)
  }
  
  public func getFavouriteById(id: String) {
    getbyIdUseCase.execute(request: id)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.favouriteData = nil
          self.isFavourite = false
        case .finished:
          print("Finish")
        }
      }, receiveValue: { favourite in
          self.isFavourite = true
          self.favouriteData = favourite
      })
      .store(in: &cancellables)
  }
  
  public func addFavourite(request: RestaurantDomainModel) {
    storeUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.isFavourite = false
          print("Error")
        case .finished:
          print("Add")
        }
      }, receiveValue: { favourite in
        if (favourite) {
          self.isFavourite = true
        } else {
          self.isFavourite = false
        }
      })
      .store(in: &cancellables)
  }
  
  public func deleteFavourite() {
      deleteUseCase.execute(request: favouriteData!)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.isFavourite = true
          print("Error")
        case .finished:
          print("Delete")
        }
      }, receiveValue: { favourite in
        if favourite {
          self.favouriteData = nil
          self.isFavourite = false
        } else {
          self.isFavourite = true
        }
      })
      .store(in: &cancellables)
  }
  
  public func linkBuilder<Content1: View, Content2: View>(
    title: String,
    destination: () -> Content1,
    @ViewBuilder content: () -> Content2
  ) -> some View {
    ZStack {
      content()
      NavigationLink(
        destination: destination()
          .navigationTitle(Text(title))
      ) {
          EmptyView()
        }
        .opacity(0)
    }
  }

}
