
// =========================================
//  ShareSheet.swift
//  iOSApp5
// =========================================
//  Created by Fozia Akhtar
// =========================================
//  Purpose:
//  Displays Apple's built-in Share Sheet.
// =========================================
//  Learning Outcomes:
//  ✓ UIActivityViewController
//  ✓ UIKit Integration
// =========================================

import SwiftUI
import UIKit

// Allows SwiftUI to display a UIKit Share Sheet
struct ShareSheet: UIViewControllerRepresentable {

    // Items that will be shared
    var activityItems: [Any]

    // Create the Share Sheet
    func makeUIViewController(context: Context) -> UIActivityViewController {

        UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
    }

    // Nothing to update while it is displayed
    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: Context
    ) {

    }
}
