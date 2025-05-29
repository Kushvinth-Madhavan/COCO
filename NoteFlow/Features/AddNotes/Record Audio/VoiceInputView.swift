//
//  VoiceInputView.swift
//  NoteFlow
//
//  Created by Kushvinth Madhavan on 26/05/25.
//

import SwiftUI
import AVFoundation

class AudioRecorder: ObservableObject {
    @Published var isRecording = false
    @Published var recordingTime: TimeInterval = 0
    private var audioRecorder: AVAudioRecorder?
    private var timer: Timer?
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audioFilename = documentPath.appendingPathComponent("recording.m4a")
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()
            
            isRecording = true
            startTimer()
        } catch {
            print("Could not start recording: \(error)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        stopTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.recordingTime += 1
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        recordingTime = 0
    }
}

struct VoiceInputView: View {
    @StateObject private var audioRecorder = AudioRecorder()
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ZStack {
            //Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("NoteFlow")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)
                
                VStack(spacing: 16) {
                    // Timer Display
                    Text(String(format: "%d:%02d",
                               Int(audioRecorder.recordingTime) / 60,
                               Int(audioRecorder.recordingTime) % 60))
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.red)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Capsule().fill(Color(.systemGray6)))
                    
                    // Recording Status
                    Text("Recording started!")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Text("Add notes, images, or bookmark key\npoints in your recording here.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .font(.body)
                }
                .padding(.vertical)
                
                Spacer()
                
                // Control Buttons
                HStack(spacing: 20) {
                    Button(action: { showingDeleteAlert = true }) {
                        Text("Delete")
                            .foregroundColor(.red)
                            .padding()
                            .background(Capsule().fill(Color(.systemGray6)))
                            .cornerRadius(16)
                    }
                    
                    Button(action: {
                        if audioRecorder.isRecording {
                            audioRecorder.stopRecording()
                        } else {
                            audioRecorder.startRecording()
                        }
                    }) {
                        Text(audioRecorder.isRecording ? "Pause" : "Resume")
                            .foregroundColor(.white)
                            .padding()
                            .background(Capsule().fill(Color.red))
                            .cornerRadius(16)
                    }
                    
                    Button(action: {
                        audioRecorder.stopRecording()
                        dismiss()
                    }) {
                        Text("Save")
                            .foregroundColor(.black)
                            .padding()
                            .background(Capsule().fill(Color(.systemGray6)))
                            .cornerRadius(16)
                    }
                }
                .padding(.bottom)
            }
        }
        .onAppear {
            audioRecorder.startRecording()
        }
        .alert("Delete Recording?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                audioRecorder.stopRecording()
                audioRecorder.resetTimer()
                dismiss()
            }
        } message: {
            Text("This action cannot be undone.")
        }
    }
}


#Preview {
    VoiceInputView()
}

