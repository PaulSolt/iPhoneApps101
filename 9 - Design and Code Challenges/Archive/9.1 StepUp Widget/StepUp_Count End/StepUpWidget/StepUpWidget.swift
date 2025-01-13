//
//  StepUpWidget.swift
//  StepUpWidget
//
//  Created by Paul Solt on 12/19/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct StepUpWidgetEntryView : View {
    var entry: Provider.Entry

    let steps: Int = 2420
    let streakCount: Int = 15
    let progressComplete: Int = 4 // [0, 10+]

    var body: some View {
        VStack(alignment: .leading) {
            Text(steps, format: .number.grouping(.automatic))
                .bold()
            Text("steps today")
                .font(.system(size: 13))

            Spacer()

            HStack {
                Image(systemName: "bolt.fill")
                VStack(alignment: .leading) {
                    Text("\(streakCount, format: .number.grouping(.automatic)) day") // day quantity? (days vs day)
                    Text("streak")
                }
                .font(.system(size: 13))
                Spacer()
            }

            StepProgress(count: progressComplete)
        }
//        .background(.yellow)
        .foregroundStyle(.green)
        .monospaced()
    }
}

struct StepProgress: View {
    let count: Int

    let hSpace: CGFloat = 3

    var body: some View {
        VStack(spacing: 5) {
            // 5 elements in a row
            HStack(spacing: hSpace) {
                ForEach(1...5, id: \.self) { number in
                    Rectangle()
                        .frame(height: 5)
                        .foregroundStyle(count >= number ? .primary : .secondary)
                }
            }

            HStack(spacing: hSpace) {
                ForEach(1...5, id: \.self) { number in
                    Rectangle()
                        .frame(height: 5)
                        .foregroundStyle(count >= number + 5 ? .primary : .secondary)
                }
            }
        }
    }
}


struct StepUpWidget: Widget {
    let kind: String = "StepUpWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            StepUpWidgetEntryView(entry: entry)
                .containerBackground(.black, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    StepUpWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
