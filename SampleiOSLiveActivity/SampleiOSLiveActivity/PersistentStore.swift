//
//  PersistentStore.swift
//  SampleiOSLiveActivity
//
//  Created by Debanjan Chakraborty on 16/07/24.
//

import Foundation

final class PersistentStore {

    static let sharedInstance: PersistentStore = PersistentStore()

    private let dataLayer: UserDefaults = UserDefaults(suiteName: Constants.suiteName)!

    private enum Constants {
        static let suiteName: String = "group.com.SampleiOSLiveActivity"
    }

    @discardableResult func insertOrUpdate(_ data: String, for key: String) -> Bool {
        dataLayer.setValue(data, forKey: key)
        return dataLayer.synchronize()
    }

    subscript(keyValue: String) -> String? {
        dataLayer.string(forKey: keyValue)
    }
}
