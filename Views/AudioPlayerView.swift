
// ===============================================
//  AudioPlayerView.swift
//  iOSApp5
// ===============================================
//  Created by Fozia Akhtar
// ===============================================
//  Purpose:
//  Plays the selected audio file using AVAudioPlayer.
//  Provides play, pause, stop controls,
//  volume adjustment, and audio sharing.
// ===============================================
//  Learning Outcomes:
//  ✓ AVAudioPlayer
//  ✓ NavigationLink Destination
//  ✓ UIActivityViewController
//  ✓ ShareSheet Integration
//  ✓ EnvironmentObject
//  ✓ UserDefaults Settings
// ===============================================

import SwiftUI
import AVFoundation



// Displays and controls audio playback.
struct AudioPlayerView: View {


    // The selected audio received from AudioListView
    let audio: Audio



    // Access shared application settings
    @EnvironmentObject var settings: AppSettings



    // Stores the AVAudioPlayer object
    @State private var audioPlayer: AVAudioPlayer?



    // Controls the volume level
    @State private var volume: Float = 0.7



    // Controls whether the Share Sheet is visible
    @State private var showingShareSheet = false





    var body: some View {


        VStack(spacing: 30) {



            // Audio icon
            Image(systemName: "music.note.circle.fill")

                .font(.system(size: 100))

                .foregroundStyle(.blue)




            // Audio title
            Text(audio.name)

                .font(.title)

                .bold()




            // Audio duration
            Text(audio.duration)

                .foregroundStyle(.secondary)





            // MARK: - Audio Controls



            HStack(spacing: 25) {



                // Play button
                Button {


                    playAudio()



                } label: {


                    Image(systemName: "play.fill")

                        .font(.title)



                }






                // Pause button
                Button {


                    pauseAudio()



                } label: {


                    Image(systemName: "pause.fill")

                        .font(.title)



                }






                // Stop button
                Button {


                    stopAudio()



                } label: {


                    Image(systemName: "stop.fill")

                        .font(.title)



                }


            }






            // MARK: - Volume Control



            VStack {


                Text("Volume")

                    .font(.headline)





                Slider(

                    value: Binding(

                        get: {

                            volume

                        },

                        set: {

                            newValue in


                            volume = newValue


                            audioPlayer?.volume = newValue


                        }

                    ),

                    in: 0...1

                )

            }







            // MARK: - Share Button



            Button {


                showingShareSheet = true



            } label: {


                Label(

                    "Share Audio",

                    systemImage: "square.and.arrow.up"

                )


            }

            .buttonStyle(.bordered)




        }





        // Screen title
        .navigationTitle(audio.name)





        // Load audio when screen appears
        .onAppear {


            loadAudio()



        }





        // Stop audio when leaving screen
        .onDisappear {


            stopAudio()



        }





        // Present Apple's Share Sheet
        .sheet(isPresented: $showingShareSheet) {



            if let url = audioURL {



                ShareSheet(

                    activityItems: [url]

                )

            }

        }

    }








    // MARK: - Audio URL





    // Finds the audio file inside the application bundle
    private var audioURL: URL? {


        Bundle.main.url(

            forResource: audio.fileName

                .replacingOccurrences(

                    of: ".mp3",

                    with: ""

                ),

            withExtension: "mp3"

        )

    }








    // MARK: - Load Audio





    /// Loads the selected audio file.
    /// Uses AVAudioPlayer to prepare playback.
    /// Uses AppSettings default volume.
    private func loadAudio() {



        guard let url = audioURL else {


            print("Audio file not found.")


            return

        }






        do {



            // Create AVAudioPlayer
            audioPlayer = try AVAudioPlayer(

                contentsOf: url

            )





            // Load default volume from Settings.bundle
            volume = settings.defaultVolume





            // Apply volume setting
            audioPlayer?.volume = settings.defaultVolume





            // Prepare audio for playback
            audioPlayer?.prepareToPlay()



        } catch {



            print(

                "Audio loading error: \(error.localizedDescription)"

            )

        }

    }








    // MARK: - Playback Controls





    // Starts audio playback
    private func playAudio() {


        audioPlayer?.play()


    }







    // Pauses audio playback
    private func pauseAudio() {


        audioPlayer?.pause()


    }







    // Stops audio playback and resets position
    private func stopAudio() {


        audioPlayer?.stop()


        audioPlayer?.currentTime = 0


    }

}








#Preview {


    NavigationStack {


        AudioPlayerView(

            audio: Audio(

                name: "Sample Audio",

                fileName: "audio1.mp3",

                duration: "00:00"

            )

        )

    }

    .environmentObject(

        AppSettings()

    )

}
