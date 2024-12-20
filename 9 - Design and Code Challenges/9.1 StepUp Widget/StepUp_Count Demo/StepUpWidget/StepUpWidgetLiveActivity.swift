//
//  StepUpWidgetLiveActivity.swift
//  StepUpWidget
//
//  Created by Paul Solt on 12/19/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct StepUpWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct StepUpWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: StepUpWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension StepUpWidgetAttributes {
    fileprivate static var preview: StepUpWidgetAttributes {
        StepUpWidgetAttributes(name: "World")
    }
}

extension StepUpWidgetAttributes.ContentState {
    fileprivate static var smiley: StepUpWidgetAttributes.ContentState {
        StepUpWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: StepUpWidgetAttributes.ContentState {
         StepUpWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: StepUpWidgetAttributes.preview) {
   StepUpWidgetLiveActivity()
} contentStates: {
    StepUpWidgetAttributes.ContentState.smiley
    StepUpWidgetAttributes.ContentState.starEyes
}
