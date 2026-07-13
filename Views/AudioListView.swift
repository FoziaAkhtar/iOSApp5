
// ===============================================
//  AudioListView.swift
//  iOSApp5
// ===============================================
//  Created by Fozia Akhtar
// ===============================================
//  Purpose:
//  Displays all audio files found in the app bundle.
// ===============================================
//  Learning Outcomes:
//  ✓ List
//  ✓ NavigationLink
//  ✓ Searchable
//  ✓ ObservableObject
// ===============================================

import SwiftUI


struct AudioListView: View {


    // Access AudioLoader
    @StateObject private var audioLoader = AudioLoader()



    // Search text entered by user
    @State private var searchText = ""



    // Filters audio based on search
    var filteredAudio: [Audio] {


        if searchText.isEmpty {

            return audioLoader.audios

        } else {

            return audioLoader.audios.filter {

                $0.name.localizedCaseInsensitiveContains(
                    searchText
                )

            }
        }
    }




    var body: some View {


        List(filteredAudio) { audio in


            NavigationLink {


                AudioPlayerView(audio: audio)


            } label: {


                HStack(spacing: 15) {


                    Image(systemName: "music.note")

                        .font(.largeTitle)

                        .frame(
                            width: 60,
                            height: 60
                        )



                    VStack(alignment: .leading) {


                        Text(audio.name)

                            .font(.headline)



                        Text(audio.duration)

                            .foregroundStyle(.secondary)

                    }

                }

            }

        }

        .navigationTitle("Audio")

        .searchable(
            text: $searchText
        )

    }
}



#Preview {

    NavigationStack {

        AudioListView()

    }
}
