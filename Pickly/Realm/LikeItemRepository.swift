//
//  LikeItemRepository.swift
//  Pickly
//
//  Created by Jaehui Yu on 3/5/25.
//

import Foundation
import RealmSwift

final class LikeItemRepository {
    static let shared = LikeItemRepository()
    
    private let realm = try! Realm()
    private init() {}
    
    func createItem(_ item: LikeItem) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func fetchItem() -> [LikeItem] {
        print(realm.configuration.fileURL)
        let results = realm.objects(LikeItem.self)
        return Array(results)
    }
    

    func deleteItem(_ item: LikeItem) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    func clearRealmData() {
        try! realm.write {
            realm.deleteAll()
        }
    }

}
