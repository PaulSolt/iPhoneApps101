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

// 1. Layout
// 2. Design
// 3. Cleanup

struct StepUpWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            Text("4,790")
                .font(.system(size: 30, weight: .semibold).monospaced())

            Text("steps")
                .font(.system(size: 20))
                .monospaced()

            Spacer()

            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "bolt.fill")
//                    Image(systemName: "shoeprints.fill")
                    VStack(alignment: .leading) {
                        Text("171 days!")
                    }
                    .font(.system(size: 12))
                    .monospaced()
                    Spacer()
                }

                StepProgress(count: 2)
            }
        }
        .foregroundStyle(.green)
    }
}

struct StepProgress: View {
    var count: Int
    let spacing: CGFloat = 3
    let height: CGFloat = 5

    var body: some View {
        VStack(spacing: spacing) {
            HStack(spacing: spacing) {
                ForEach(1...5, id: \.self) { index in
                    let isFilled = index <= count
                    Rectangle()
                        .frame(height: height)
                        .foregroundStyle(isFilled ? .primary : .secondary)
                }
            }
            
            HStack(spacing: spacing) {
                ForEach(1...5, id: \.self) { index in
                    let isFilled = index + 5 <= count
                    Rectangle()
                        .frame(height: height)
                        .foregroundStyle(isFilled ? .primary : .secondary)
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
//                .containerBackground(.fill.secondary, for: .widget)
                .containerBackground(.black, for: .widget)
//                .containerBackground(for: .widget) { // EXTRA: If time
//                    ZStack {
//                        Color.black
//                        ContainerRelativeShape()
//                            .stroke(lineWidth: 5)
//                            .foregroundStyle(.green)
//                    }
//                }
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
//    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
