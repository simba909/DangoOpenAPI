//
//  ContentView.swift
//  DangoOpenAPI
//
//  Created by Simon Jarbrant on 2024-01-19.
//

import Data
import SwiftUI

struct ContentView: View {
    @State var channels: [Channel] = []

    var body: some View {
        List {
            ForEach(channels) { channel in
                Text(channel.name)
            }
        }
        .task {
            do {
                let dataSource = ChannelsDataSource()
                self.channels = try await dataSource.channels()
            } catch {
                print("oh no", error)
            }
        }
    }
}

#Preview {
    ContentView()
}
