//
//  UpdateWithUserNameLiveActivity.swift
//  UpdateWithUserName
//
//  Created by Debanjan Chakraborty on 16/07/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct UpdateWithUserNameLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: UserNameLiveActivityDataAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("There has been a new input. Check")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading part")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing part")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.firstName)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.firstName)")
            } minimal: {
                Text(context.state.firstName)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}
/*
extension UpdateWithUserNameAttributes {
    fileprivate static var preview: UpdateWithUserNameAttributes {
        UpdateWithUserNameAttributes(name: "World")
    }
}

extension UpdateWithUserNameAttributes.ContentState {
    fileprivate static var smiley: UpdateWithUserNameAttributes.ContentState {
        UpdateWithUserNameAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: UpdateWithUserNameAttributes.ContentState {
         UpdateWithUserNameAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: UpdateWithUserNameAttributes.preview) {
   UpdateWithUserNameLiveActivity()
} contentStates: {
    UpdateWithUserNameAttributes.ContentState.smiley
    UpdateWithUserNameAttributes.ContentState.starEyes
}
*/
