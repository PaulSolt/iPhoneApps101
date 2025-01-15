//
//  StepCounterWidget.swift
//  StepCounterWidget
//
//  Created by Paul Solt on 1/13/25.
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

// UI
// 1. Layout
// 2. Design
// 3. Cleanup

struct StepCounterWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("6,790")
                .font(.system(size: 30, weight: .bold).monospaced())

            Text("steps")
                .font(.system(size: 20).monospaced())
                .foregroundStyle(.secondary)

            Spacer()

            HStack {
                Image(systemName: "bolt.fill") // "shoeprints.fill")
                Text("173 days!")
            }
            .font(.system(size: 16).monospaced())
            .padding(.bottom, 4)

            StepProgress(progress: 6)
        }
        .foregroundStyle(.green)
    }
}

struct StepProgress: View {
    let progress: Int
    let rows: Int = 2
    let segmentsPerRow: Int = 5
    let spacing: CGFloat = 3

    var body: some View {
        VStack(spacing: spacing) {
            ForEach(1...rows, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(1...segmentsPerRow, id: \.self) { segment in
                        let index = (row - 1) * segmentsPerRow + segment
                        let isFilled = index <= progress
                        let _ = print("index: \(index), isFilled: \(isFilled)")
                        Rectangle()
                            .frame(height: 5)
                            .foregroundStyle(isFilled ? .primary : .secondary)
                    }
                }
            }
        }
    }
}


struct StepCounterWidget: Widget {
    let kind: String = "StepCounterWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            StepCounterWidgetEntryView(entry: entry)
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
    StepCounterWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
