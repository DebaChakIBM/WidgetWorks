//
//  UpdateWithUserName.swift
//  UpdateWithUserName
//
//  Created by Debanjan Chakraborty on 16/07/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), userName: userName)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), userName: userName)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, userName: userName)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    private var userName: String {
        if let fName = PersistentStore.sharedInstance[Constants.profileNameKey],
           let lName = PersistentStore.sharedInstance[Constants.profileSurnameKey] {
           return  fName + " " + lName
        } else {
            return ""
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let userName: String
}

struct UpdateWithUserNameEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("User Name:")
            Text(entry.userName)
        }
    }
}

struct UpdateWithUserName: Widget {
    let kind: String = "Update With User Name"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                UpdateWithUserNameEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                UpdateWithUserNameEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    UpdateWithUserName()
} timeline: {
    SimpleEntry(date: .now, userName: "Sample")
    SimpleEntry(date: .now, userName: "🤩")
}
