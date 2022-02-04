//
//  Checkin_Widget.swift
//  Checkin Widget
//
//  Created by ryo fuj on 2/2/22.
//

import WidgetKit
import SwiftUI

struct ContributionsGraphEntry: TimelineEntry {
    let date: Date
    let days: [DevelopmentDay]
}

struct Provider: TimelineProvider {
    
    private var dummyEntry: ContributionsGraphEntry {
        let now = Date()
        let days = (0 ..< 119).map { index -> DevelopmentDay in
            let date = Calendar.current.date(
                byAdding: .day,
                value: -index,
                to: now
            )!
            return DevelopmentDay(date: date, dataCount: 0)
        }
        return ContributionsGraphEntry(date: now, days: days)
    }
    
    func placeholder(in context: Context) -> ContributionsGraphEntry {
        dummyEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ContributionsGraphEntry) -> Void) {
        completion(dummyEntry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ContributionsGraphEntry>) -> Void) {
        GitHubParser.getDevelopmentDays(for: "ryofuj") { days in
            let entry = ContributionsGraphEntry(date: Date(), days: days)
            let _5Minutes = Date().addingTimeInterval(300)
            let timeline = Timeline(
                entries: [entry],
                policy: TimelineReloadPolicy.after(_5Minutes)
            )
            completion(timeline)
        }
    }
}

struct WidgetEntryView: View {
    let entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            ContributionGraphView(days: entry.days, selectedDay: {_ in})
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ContainerRelativeShape().fill(Color(.black).opacity(0.9)))
            .padding(.horizontal, 180.0)
            .padding(30.0)
            
        case .systemMedium:
            ContributionGraphView(days: entry.days, selectedDay: {_ in})
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ContainerRelativeShape().fill(Color(.green).opacity(0.9)))
            .padding(30)

        default:
            ContributionGraphView(days: entry.days, selectedDay: {_ in})
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ContainerRelativeShape().fill(Color(.green).opacity(0.9)))
            .padding(50.0)
        }
        
    }
}

@main
struct ContributionsGraphWidget: Widget {
    private let kind = "Checkin_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemExtraLarge])
        
    }
}
