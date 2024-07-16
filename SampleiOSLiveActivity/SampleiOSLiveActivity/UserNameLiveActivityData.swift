//
//  UserNameLiveActivityData.swift
//  SampleiOSLiveActivity
//
//  Created by Debanjan Chakraborty on 16/07/24.
//

import Foundation
import ActivityKit

struct UserNameLiveActivityDataAttributes: ActivityAttributes, Identifiable {
    public typealias LiveData = ContentState

    public struct ContentState: Codable, Hashable {
        var deliveryTime: Date
        var firstName: String
        var lastName: String
    }

    var id = UUID()
}
