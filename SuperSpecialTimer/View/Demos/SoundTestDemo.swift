//
//  SoundTestDemo.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-11-03.
//

import SwiftUI
import AVFoundation

struct SoundTestDemo: View {
  @State private var player: AVAudioPlayer?
  @State private var selectedSound: String = "bell_sound_2"

  let soundNames = ["bell_sound_2"]

  var body: some View {
    VStack {
      Picker(selection: $selectedSound, label: Text("Select Sound")) {
        ForEach(soundNames, id: \.self) {
          Text($0)
        }
      }
      .padding()

      Button(action: {
        self.playSound()
      }) {
        Text("Play Sound")
      }
    }
  }

  func playSound() {
    guard let soundURL = Bundle.main.url(forResource: selectedSound, withExtension: "wav") else {
      return
    }

    do {
     try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [])
      player = try AVAudioPlayer(contentsOf: soundURL)
        
      print("Sound successfully loaded")
    } catch {
      print("Failed to load the sound: \(error)")
    }
    player?.play()
  }
}
