
// ========================================================
//  VideoLoader.swift
//  iOSApp5
// ========================================================
//  Created by Fozia Akhtar
// ========================================================
//  Purpose:
//  This class loads all video files from the app bundle.
//  It creates thumbnails and finds video duration.
//  It publishes video data so SwiftUI updates automatically.
// =========================================================
//  Learning Outcomes:
//  ✓ ObservableObject
//  ✓ AVAsset
//  ✓ AVAssetImageGenerator
//  ✓ FileManager
//  ✓ Bundle
// ==========================================================

import Foundation
import Combine
import AVFoundation
import UIKit


// ObservableObject allows SwiftUI views to receive updates
class VideoLoader: ObservableObject {


    // List of videos found in the application bundle
    @Published var videos: [Video] = []



    // Load videos when this class is created
    init() {

        loadVideos()

    }



    // MARK: - Load Videos


    /// Loads all MP4 video files from the application bundle.
    /// Uses FileManager to search resources.
    func loadVideos() {


        // Remove previous video data
        videos.removeAll()



        // Locate the application bundle
        guard let resourcePath = Bundle.main.resourcePath else {

            print("Could not locate Bundle.")

            return
        }



        do {


            // Get all files from bundle including folders
            let files = try FileManager.default
                .subpathsOfDirectory(atPath: resourcePath)



            // Keep only MP4 video files
            let videoFiles = files.filter {

                $0.lowercased().hasSuffix(".mp4")

            }



            // Debug check
            print("Videos found in bundle:", videoFiles)



            // Create Video objects
            for file in videoFiles {


                let name = file
                    .replacingOccurrences(
                        of: ".mp4",
                        with: ""
                    )
                    .capitalized



                let duration = getVideoDuration(
                    fileName: file
                )



                let thumbnail = createThumbnail(
                    fileName: file
                )



                let video = Video(

                    name: name,

                    fileName: file,

                    thumbnail: thumbnail,

                    duration: duration

                )



                videos.append(video)

            }



            // Sort videos alphabetically
            videos.sort {

                $0.name < $1.name

            }



        } catch {


            print(
                "Error loading videos: \(error.localizedDescription)"
            )

        }
    }




    // MARK: - Video Duration


    /// Calculates video duration using AVAsset.
    /// Returns time in mm:ss format.
    private func getVideoDuration(
        fileName: String
    ) -> String {



        guard let url = Bundle.main.url(

            forResource: fileName
                .replacingOccurrences(
                    of: ".mp4",
                    with: ""
                ),

            withExtension: "mp4"

        ) else {

            return "00:00"

        }



        // Create AVAsset from video URL
        let asset = AVAsset(url: url)



        let seconds = Int(
            CMTimeGetSeconds(asset.duration)
        )



        let minutes = seconds / 60



        let remainingSeconds = seconds % 60



        return String(
            format: "%02d:%02d",
            minutes,
            remainingSeconds
        )

    }




    // MARK: - Thumbnail


    /// Creates a thumbnail image from the first second of the video.
    /// Uses AVAssetImageGenerator.
    private func createThumbnail(
        fileName: String
    ) -> UIImage? {



        guard let url = Bundle.main.url(

            forResource: fileName
                .replacingOccurrences(
                    of: ".mp4",
                    with: ""
                ),

            withExtension: "mp4"

        ) else {

            return nil

        }



        // Create video asset
        let asset = AVAsset(url: url)



        // Generate thumbnail image
        let imageGenerator = AVAssetImageGenerator(
            asset: asset
        )



        // Correct orientation
        imageGenerator.appliesPreferredTrackTransform = true



        do {



            let cgImage = try imageGenerator.copyCGImage(

                at: CMTime(
                    seconds: 1,
                    preferredTimescale: 600
                ),

                actualTime: nil

            )



            return UIImage(
                cgImage: cgImage
            )



        } catch {



            print(
                "Thumbnail Error: \(error.localizedDescription)"
            )

            return nil

        }
    }
}
