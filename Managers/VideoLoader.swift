
// ========================================================
//  VideoLoader.swift
//  iOSApp5
// ========================================================
//  Created by Fozia Akhtar
// ========================================================
//  Purpose:
//  This class loads all video files from the app bundle.
//  It also creates a thumbnail and finds the video duration.
// =========================================================
//  Learning Outcomes:
//  ✓ ObservableObject
//  ✓ AVAsset
//  ✓ AVAssetImageGenerator
//  ✓ Bundle
// ==========================================================

import Foundation
import Combine
import AVFoundation
import UIKit

// ObservableObject lets SwiftUI update the screen automatically
class VideoLoader: ObservableObject {

    // List of videos found in the app
    @Published var videos: [Video] = []

    // Load videos when this class is created
    init() {
        loadVideos()
    }

    // MARK: - Load Videos

    /// Loads every MP4 file from the application bundle
    func loadVideos() {

        // Remove old data before loading again
        videos.removeAll()

        // Get every resource inside the bundle
        guard let resourcePath = Bundle.main.resourcePath else {
            print("Could not locate Bundle.")
            return
        }

        do {

            // Read all files inside the bundle
            let files = try FileManager.default.contentsOfDirectory(atPath: resourcePath)

            // Keep only MP4 files
            let videoFiles = files.filter { $0.lowercased().hasSuffix(".mp4") }

            // Process every video
            for file in videoFiles {

                let name = file.replacingOccurrences(of: ".mp4", with: "")

                let duration = getVideoDuration(fileName: file)

                let thumbnail = createThumbnail(fileName: file)

                let video = Video(
                    name: name,
                    fileName: file,
                    thumbnail: thumbnail,
                    duration: duration
                )

                videos.append(video)
            }

            // Sort alphabetically
            videos.sort { $0.name < $1.name }

        } catch {

            print("Error loading videos: \(error.localizedDescription)")
        }
    }

    // MARK: - Video Duration

    /// Returns the length of a video as mm:ss
    private func getVideoDuration(fileName: String) -> String {

        guard let url = Bundle.main.url(forResource: fileName.replacingOccurrences(of: ".mp4", with: ""), withExtension: "mp4") else {
            return "00:00"
        }

        let asset = AVAsset(url: url)

        let seconds = Int(CMTimeGetSeconds(asset.duration))

        let minutes = seconds / 60

        let remainingSeconds = seconds % 60

        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }

    // MARK: - Thumbnail

    /// Creates a thumbnail from the first second of the video
    private func createThumbnail(fileName: String) -> UIImage? {

        guard let url = Bundle.main.url(forResource: fileName.replacingOccurrences(of: ".mp4", with: ""), withExtension: "mp4") else {
            return nil
        }

        let asset = AVAsset(url: url)

        let imageGenerator = AVAssetImageGenerator(asset: asset)

        imageGenerator.appliesPreferredTrackTransform = true

        do {

            let cgImage = try imageGenerator.copyCGImage(
                at: CMTime(seconds: 1, preferredTimescale: 600),
                actualTime: nil
            )

            return UIImage(cgImage: cgImage)

        } catch {

            print("Thumbnail Error: \(error.localizedDescription)")
            return nil
        }
    }
}
