
// ===========================================================
//  AudioLoader.swift
//  iOSApp5
// ===========================================================
//  Created by Fozia Akhtar
// ===========================================================
//  Purpose:
//  This file automatically loads all MP3 audio files
//  from the app bundle.
//  It also finds the duration of each audio file.
// ===========================================================
//  Learning Outcomes:
//  ✓ ObservableObject
//  ✓ FileManager
//  ✓ Bundle
//  ✓ AVAsset
// ===========================================================

import Foundation
import Combine
import AVFoundation


// This class manages all audio files in the app.
class AudioLoader: ObservableObject {


    // List of audio files found in the app
    @Published var audios: [Audio] = []



    // Automatically load audio when the class is created
    init() {

        loadAudio()

    }



    // MARK: - Load Audio Files


    /// Loads every MP3 file from the app bundle.
    /// Uses FileManager to search all resources.
    func loadAudio() {


        // Remove old data before loading again
        audios.removeAll()



        // Find the app bundle location
        guard let resourcePath = Bundle.main.resourcePath else {

            print("Could not locate Bundle.")

            return
        }



        do {


            // Search all files inside the Bundle
            let files = try FileManager.default
                .subpathsOfDirectory(atPath: resourcePath)



            // Keep only MP3 files
            let audioFiles = files.filter {

                $0.lowercased().hasSuffix(".mp3")

            }



            // Debug check
            print("Audio files found:", audioFiles)



            // Create Audio objects
            for file in audioFiles {



                let name = file
                    .replacingOccurrences(
                        of: ".mp3",
                        with: ""
                    )
                    .capitalized



                let duration = getAudioDuration(
                    fileName: file
                )



                let audio = Audio(

                    name: name,

                    fileName: file,

                    duration: duration

                )



                audios.append(audio)

            }



            // Sort alphabetically
            audios.sort {

                $0.name < $1.name

            }



        } catch {


            print(
                "Error loading audio: \(error.localizedDescription)"
            )

        }
    }





    // MARK: - Get Duration



    /// Returns the audio duration in mm:ss format.
    /// Uses AVAsset to read audio information.
    private func getAudioDuration(
        fileName: String
    ) -> String {



        guard let url = Bundle.main.url(

            forResource: fileName
                .replacingOccurrences(
                    of: ".mp3",
                    with: ""
                ),

            withExtension: "mp3"

        ) else {


            return "00:00"

        }



        // Create audio asset
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
}
