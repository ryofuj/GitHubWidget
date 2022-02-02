//
//  ContentView.swift
//  DailyCheckin
//
//  Created by ryo fuj on 2/2/22.
//

import SwiftUI

struct ContentView: View {
    let layout = [GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: layout, spacing: 20){
            LazyHGrid(rows: layout, spacing: 20){
                Text("Hello, world!")
                    .padding()
                Text("Hello, world!")
                    .padding()
            }
            Text("Hello, world!")
                .padding()
            Text("Hello, world!")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
