
// ===========================================
//  VideoListView.swift
//  iOSApp5
// ===========================================
//  Created by Fozia Akhtar
// ===========================================
//  Purpose:
//  Displays all videos found in the app bundle.
// ============================================
//  Learning Outcomes:
//  ✓ List
//  ✓ NavigationStack
//  ✓ NavigationLink
//  ✓ Searchable
//  ✓ ObservableObject
// ============================================

import SwiftUI

struct VideoListView: View {

    // Access the VideoLoader
    @StateObject private var videoLoader = VideoLoader()

    // Text entered into the search bar
    @State private var searchText = ""

    // Filter videos based on the search text
    var filteredVideos: [Video] {

        if searchText.isEmpty {
            return videoLoader.videos
        } else {
            return videoLoader.videos.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {

        List(filteredVideos) { video in

            NavigationLink {

                VideoPlayerView(video: video)
    }
            
            label: {

                HStack(spacing: 15) {

                    if let image = video.thumbnail {

                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 70)
                            .cornerRadius(10)

                    } else {

                        Image(systemName: "film")
                            .font(.largeTitle)
                            .frame(width: 120, height: 70)
                    }

                    VStack(alignment: .leading) {

                        Text(video.name)
                            .font(.headline)

                        Text(video.duration)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Videos")
        .searchable(text: $searchText)
    }
}

#Preview {

    NavigationStack {

        VideoListView()
    }
}
