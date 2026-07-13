
// ===============================================
//  VideoPlayerView.swift
//  iOSApp5
// ===============================================
//  Created by Fozia Akhtar
// ===============================================
//  Purpose:
//  Plays the selected video using AVPlayer.
//  Provides automatic playback and video sharing.
// ===============================================
//  Learning Outcomes:
//  ✓ AVPlayer
//  ✓ VideoPlayer (AVKit)
//  ✓ NavigationLink Destination
//  ✓ UIActivityViewController
//  ✓ ShareSheet Integration
// ===============================================

import SwiftUI
import AVKit


// Displays and controls video playback.
struct VideoPlayerView: View {

    // The selected video received from VideoListView
    let video: Video


    // Stores the AVPlayer used for video playback
    @State private var player: AVPlayer?


    // Controls whether the Share Sheet is visible
    @State private var showingShareSheet = false



    var body: some View {

        VStack(spacing: 20) {


            // Display the video player when AVPlayer is available
            if let player = player {

                VideoPlayer(player: player)
                    .frame(height: 300)


            } else {

                // Displayed if video cannot be loaded
                Text("Video unavailable")
                    .foregroundStyle(.secondary)

            }



            // Share button
            Button {

                showingShareSheet = true

            } label: {

                Label(
                    "Share Video",
                    systemImage: "square.and.arrow.up"
                )

            }
            .buttonStyle(.bordered)
        }



        // Screen title
        .navigationTitle(video.name)



        // Load and start video when screen appears
        .onAppear {

            loadVideo()

        }



        // Pause video when leaving screen
        .onDisappear {

            player?.pause()

        }



        // Present Apple's Share Sheet
        .sheet(isPresented: $showingShareSheet) {

            if let url = videoURL {

                ShareSheet(
                    activityItems: [url]
                )

            }

        }
    }



    // MARK: - Video URL


    // Finds the video file inside the application bundle
    private var videoURL: URL? {


        Bundle.main.url(

            forResource: video.fileName
                .replacingOccurrences(
                    of: ".mp4",
                    with: ""
                ),

            withExtension: "mp4"
        )
    }



    // MARK: - Video Loading


    /// Creates AVPlayer and starts playback
    /// Uses the video file stored in the app bundle.
    private func loadVideo() {


        guard let url = videoURL else {

            print("Video file not found.")

            return
        }



        // Create AVPlayer with the video URL
        player = AVPlayer(url: url)



        // Automatically start playing video
        player?.play()
    }
}



#Preview {

    NavigationStack {

        Text("Video Player Preview")

    }
}
