
// ===========================================
//  VideoListView.swift
//  iOSApp5
// ===========================================
//  Created by Fozia Akhtar
// ===========================================
//  Purpose:
//  Displays all videos found in the app bundle.
//  Allows users to search and open videos.
// ============================================
//  Learning Outcomes:
//  ✓ List
//  ✓ NavigationStack
//  ✓ NavigationLink
//  ✓ Searchable
//  ✓ ObservableObject
//  ✓ AVPlayer Integration
// ============================================

import SwiftUI


// Displays a list of available videos.
struct VideoListView: View {


    // Access the VideoLoader
    // Loads videos from the application bundle
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



            // Navigate to the video player screen
            NavigationLink {


                VideoPlayerView(video: video)



            } label: {



                HStack(spacing: 15) {



                    // Display video thumbnail
                    if let image = video.thumbnail {



                        Image(uiImage: image)

                            .resizable()

                            .scaledToFill()

                            .frame(
                                width: 120,
                                height: 70
                            )

                            .cornerRadius(10)



                    } else {



                        // Default image if thumbnail is unavailable
                        Image(systemName: "film")

                            .font(.largeTitle)

                            .frame(
                                width: 120,
                                height: 70
                            )

                    }




                    // Display video information
                    VStack(alignment: .leading) {



                        Text(video.name)

                            .font(.headline)




                        Text(video.duration)

                            .foregroundStyle(.secondary)



                    }
                }
            }
        }



        // Screen title
        .navigationTitle("Videos")



        // Add search bar
        .searchable(text: $searchText)



        // Debug and reload videos when screen appears
        .onAppear {


            print(
                "Videos loaded:",
                videoLoader.videos.count
            )


            // Reload videos from bundle
            if videoLoader.videos.isEmpty {


                videoLoader.loadVideos()


            }

        }
    }
}





#Preview {


    NavigationStack {


        VideoListView()


    }
}
