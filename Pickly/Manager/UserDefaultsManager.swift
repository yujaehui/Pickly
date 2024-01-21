//
//  UserDefaultsManager.swift
//  Pickly
//
//  Created by Jaehui Yu on 1/19/24.
//

import Foundation

class UserDefaultsManager {
    private init() {}
    static let shared = UserDefaultsManager()
    
    enum UDKey: String {
        case profileImage
        case nickname
        case searchList
        case productID
        case userState
    }
    
    let ud = UserDefaults.standard
    
    var profileImage: Int {
        get {
            let savedValue = ud.integer(forKey: UDKey.profileImage.rawValue)
            if savedValue == 0 {
                let randomImage = Int.random(in: 1...14)
                ud.set(randomImage, forKey: UDKey.profileImage.rawValue)
                return randomImage
            }
            return savedValue
        }
        set { ud.setValue(newValue, forKey: UDKey.profileImage.rawValue) }
    }
    var nickname: String {
        get { ud.string(forKey: UDKey.nickname.rawValue) ?? "" }
        set { ud.setValue(newValue, forKey: UDKey.nickname.rawValue) }
    }
    var searchList: [String]? {
        get { ud.array(forKey: UDKey.searchList.rawValue) as? [String] }
        set { ud.setValue(newValue, forKey: UDKey.searchList.rawValue) }
    }
    var productID: [String]? {
        get { ud.array(forKey: UDKey.productID.rawValue) as? [String] }
        set { ud.setValue(newValue, forKey: UDKey.productID.rawValue) }
    }
    var userState: Bool {
        get { ud.bool(forKey: UDKey.userState.rawValue) }
        set { ud .setValue(newValue, forKey: UDKey.userState.rawValue)}
    }
    
    // 모든 userDefaults 항목 제거
    func clearAll() {
        for key in ud.dictionaryRepresentation().keys {
            ud.removeObject(forKey: key.description)
        }
    }
}
