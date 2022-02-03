//
//  ContentView.swift
//  DailyCheckin
//
//  Created by ryo fuj on 2/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            ContributionGraphView(days: viewModel.days,
                                  selectedDay: {viewModel.selectedDay = $0})
            if let selectedDay = viewModel.selectedDay{
                Text("\(DateService.shared.dateFormatter.string(from: selectedDay.date)) contributions on \(selectedDay.dataCount), ")
            }
        }
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var days = [DevelopmentDay]()
        @Published var selectedDay: DevelopmentDay?
        
        init() {
            getDevelopmentDays()
        }
        
        private func getDevelopmentDays() {
            GitHubParser.getDevelopmentDays(for: "ryofuj"){
                [weak self] days in
                self?.days = days
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
