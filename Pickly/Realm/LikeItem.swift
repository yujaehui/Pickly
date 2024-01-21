//
//  LikeItem.swift
//  Pickly
//
//  Created by Jaehui Yu on 3/5/25.
//

import Foundation
import RealmSwift

final class LikeItem: Object {
    @Persisted(primaryKey: true) var pk: ObjectId
    @Persisted var id: String
    @Persisted var brand: String
    @Persisted var title: String
    @Persisted var price: String
    @Persisted var link: String

    convenience init(id: String, brand: String, title: String, price: String, link: String) {
        self.init()
        self.id = id
        self.brand = brand
        self.title = title
        self.price = price
        self.link = link
    }
}
