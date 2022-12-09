//
//  FavouriteEntity.swift
//  submission-capstone-project
//
//  Created by Rezki Pratama on 21/11/22.
//

import Foundation
import RealmSwift

public class FavouriteModuleEntity: Object {

  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var desc: String = ""
  @objc dynamic var pictureId: String = ""
  @objc dynamic var city: String = ""
  @objc dynamic var rating: Double = 0.0
  @objc dynamic var address: String = ""

  public override static func primaryKey() -> String? {
    return "id"
  }
}
