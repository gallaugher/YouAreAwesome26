//  ContentView.swift
//  YouAreAwesome
//  Created by John Gallaugher on 8/21/25.
//  YouTube.com/profgallaugher - gallaugher.bsky.social

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var message = ""
    @State private var imageName = ""
    @State private var lastMessageNumber = -1
    @State private var lastImageNumber = -1
    @State private var lastSoundNumber = -1
    @State private var audioPlayer: AVAudioPlayer!
    @State private var soundIsOn = true
    let numberOfImages = 10
    let numberOfSounds = 6
    
    var body: some View {
        
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(height: 100)
                .animation(.easeInOut(duration: 0.15), value: message)
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(radius: 30)
                .animation(.default, value: imageName)
            
            Spacer()
            
            HStack {
                //                Text("Sound on:")
                //                Toggle("Sound on:", isOn: $soundIsOn)
                //                    .labelsHidden()
                Toggle("Sound on:", isOn: $soundIsOn)
                    .fixedSize(horizontal: true, vertical: false)
                    .onChange(of: soundIsOn) {
                        if audioPlayer != nil && audioPlayer.isPlaying {
                            audioPlayer.stop()
                        }
                    }
                
                Spacer()
                
                Button("Show Message!") {
                    
                    let messages = ["You Are Awesome!",
                                    "When the Genius Bar Needs Help, They Call You!",
                                    "You Are Great!",
                                    "You Are Fantastic!",
                                    "Fabulous? That's You!",
                                    "You Make Me Smile"]
                    
                    lastMessageNumber = nonRepeatingCode(lastNumber: lastMessageNumber, upperBound: messages.count-1)
                    message = messages[lastMessageNumber]
                    
                    lastImageNumber = nonRepeatingCode(lastNumber: lastImageNumber, upperBound: numberOfImages-1)
                    imageName = "image\(lastImageNumber)"
                    
                    lastSoundNumber = nonRepeatingCode(lastNumber: lastSoundNumber, upperBound: numberOfSounds-1)
                    if soundIsOn {
                        playSound(soundName: "sound\(lastSoundNumber)")
                    }
                }
                .buttonStyle(.borderedProminent)
                .font(.title2)
            }
            .tint(.accentColor)
        }
        .padding()
        
    }
    
    func nonRepeatingCode(lastNumber: Int, upperBound: Int) -> Int {
        var newNumber: Int
        repeat {
            newNumber = Int.random(in: 0...upperBound)
        } while newNumber == lastNumber
        return newNumber
    }
    
    func playSound(soundName: String) {
        if audioPlayer != nil && audioPlayer.isPlaying {
                audioPlayer.stop()
        }
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) creating audioPlayer.")
        }
    }
}

#Preview("Light Mode") {
    ContentView()
        .preferredColorScheme(.light)
}
#Preview("Dark Mode") {
    ContentView()
        .preferredColorScheme(.dark)
}
