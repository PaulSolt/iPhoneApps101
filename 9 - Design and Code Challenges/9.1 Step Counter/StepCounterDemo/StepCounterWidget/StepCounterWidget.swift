//
//  StepCounterWidget.swift
//  StepCounterWidget
//
//  Created by Paul Solt on 1/11/25.
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

import Foundation

struct StepData {
    let steps: Int
    let streakInDays: Int
    let progress: Int

    static let mock = StepData(
        steps: 4790,
        streakInDays: 173,
        progress: 4
    )
}

struct StepCounterWidgetEntryView : View {
    var stepData: StepData = .mock
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) { //, spacing: 0) {
            Text("\(stepData.steps)") //.precision(.fractionLength(0)))")
                .font(.system(size: 30, weight: .semibold).monospaced()) // SF Mono (Menlo)
//                .foregroundStyle(.green)

            Text("steps")
                .font(.system(size: 22))
                .foregroundStyle(.secondary)

            Spacer()
            VStack(alignment: .leading) {//}, spacing: 10) {
                HStack {
                    Image(systemName: "bolt.fill") // shoeprints.fill
                    Text("\(stepData.streakInDays) days!")
                }
                .font(.system(size: 16))

                StepProgress(progress: stepData.progress)
            }
        }
        .foregroundStyle(.green)
    }
}

struct StepProgress: View {
    let progress: Int // [0, 10]  0, 1, 4, 10 (-1, 11+)

    let spacing: CGFloat = 3
    let height: CGFloat = 5
    let rows: Int = 2
    var segmentsPerRow: Int = 5

    var body: some View {
        VStack(spacing: spacing) {
            ForEach(1...rows, id: \.self) { row in

                HStack(spacing: spacing) {
                    ForEach(1...segmentsPerRow, id: \.self) { segment in
                        let index = segment + (row - 1) * segmentsPerRow
                        let isFilled = index <= progress
                        let _ = print("\(row), \(index)")

                        Rectangle()
                            .frame(height: height)
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
    StepCounterWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
