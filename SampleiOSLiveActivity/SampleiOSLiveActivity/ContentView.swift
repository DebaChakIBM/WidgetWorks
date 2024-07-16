//
//  ContentView.swift
//  SampleiOSLiveActivity
//
//  Created by Debanjan Chakraborty on 16/07/24.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct ContentView: View{
    @State var activities = Activity<UserNameLiveActivityDataAttributes>.activities
    @State private var profileName = PersistentStore.sharedInstance[Constants.profileNameKey] ?? ""
    @State private var profileSurname: String = PersistentStore.sharedInstance[Constants.profileSurnameKey] ?? ""

    var body: some View{
        ZStack{
            VStack{
                TextField("Name", text: $profileName)
                    .frame(height: 60)
                    .padding([.leading, .trailing], 20)
                    .foregroundColor(.black)
                    .font(Font.system(size: 30, design: .default))
                    .multilineTextAlignment(.center)
                    .accentColor(Color.white)
                    .overlay(RoundedRectangle(cornerRadius:30)
                        .stroke(Color.gray, lineWidth: 1)).padding(.horizontal, 50)

                TextField("Surname", text: $profileSurname)
                    .frame(height: 60)
                    .padding([.leading, .trailing], 20)
                    .font(Font.system(size: 30, design: .default))
                    .multilineTextAlignment(.center)
                    .accentColor(Color.white)
                    .overlay(RoundedRectangle(cornerRadius:30)
                        .stroke(Color.gray, lineWidth: 1)).padding(.horizontal, 50)

                Button(action: {
                    PersistentStore.sharedInstance.insertOrUpdate(profileSurname, for: Constants.profileSurnameKey)
                    PersistentStore.sharedInstance.insertOrUpdate(profileName, for: Constants.profileNameKey)

                    // This is to reload the local widget
                    WidgetCenter.shared.reloadAllTimelines()
                }, label: {
                    Text("Update Local Widget")
                        .frame(width:300 , height: 40)
                        .padding(10)
                        .font(Font.system(size: 30, weight: .medium))
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 45))
                        .foregroundColor(.init(red: 45 / 255, green: 0 / 255, blue: 112 / 255))

                })

                Button(action: {
                    createOrUpdate()
                }, label: {
                    Text("Show in Dynamic Island")
                        .frame(width:300 , height: 40)
                        .padding(10)
                        .font(Font.system(size: 30, weight: .medium))
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 45))
                        .foregroundColor(.init(red: 45 / 255, green: 0 / 255, blue: 112 / 255))

                })
            }
        }
    }

    private func createOrUpdate() {
        if let localActivity = activities.first {
            update(activity: localActivity)
        } else {
            createActivity()
        }
    }

    private func createActivity() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in

            if let error = error {
                debugPrint("error was \(error)")
            }
        }

        let attributes = UserNameLiveActivityDataAttributes()
        let contentState = UserNameLiveActivityDataAttributes.LiveData(deliveryTime: .now,
                                                                       firstName: profileName,
                                                                       lastName: profileSurname)
        do {
            let _ = try Activity<UserNameLiveActivityDataAttributes>.request(
                attributes: attributes,
                contentState: contentState,
                pushType: .token)

            var activities = Activity<UserNameLiveActivityDataAttributes>.activities
            activities.sort { $0.id > $1.id }
            self.activities = activities

        } catch (let error) {
            print(error.localizedDescription)
        }
    }

    func update(activity: Activity<UserNameLiveActivityDataAttributes>) {
        Task {
            let contentState = UserNameLiveActivityDataAttributes.LiveData(deliveryTime: .now,
                                                                           firstName: profileName,
                                                                           lastName: profileSurname)
            await activity.update(using: contentState)
        }
    }
}

#Preview {
    ContentView()
}
