//
//  StepCounterWidgetLiveActivity.swift
//  StepCounterWidget
//
//  Created by Paul Solt on 1/11/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct StepCounterWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct StepCounterWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: StepCounterWidgetAttributes.self) { context in
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

extension StepCounterWidgetAttributes {
    fileprivate static var preview: StepCounterWidgetAttributes {
        StepCounterWidgetAttributes(name: "World")
    }
}

extension StepCounterWidgetAttributes.ContentState {
    fileprivate static var smiley: StepCounterWidgetAttributes.ContentState {
        StepCounterWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: StepCounterWidgetAttributes.ContentState {
         StepCounterWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: StepCounterWidgetAttributes.preview) {
   StepCounterWidgetLiveActivity()
} contentStates: {
    StepCounterWidgetAttributes.ContentState.smiley
    StepCounterWidgetAttributes.ContentState.starEyes
}
