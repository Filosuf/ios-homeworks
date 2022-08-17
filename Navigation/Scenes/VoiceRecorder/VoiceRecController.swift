//
//  VoiceRecController.swift
//  Navigation
//
//  Created by 1234 on 15.08.2022.
//
//  В разработке использовалась статья
//  https://www.hackingwithswift.com/example-code/media/how-to-record-audio-using-avaudiorecorder

import UIKit
import AVKit

class VoiceRecController: UIViewController {

    //MARK: - Properties
    var Player: AVAudioPlayer?
    lazy var voiceRecView = VoiceRecView(delegate: self)
    var recordingSessions: AVAudioSession!
    var voiceRecorder: AVAudioRecorder!
    let recordedFileUrl = URL.init(fileURLWithPath: Bundle.main.path(forResource: "sample3", ofType: "m4a")!)

    //MARK: - LifeCicle
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Диктофон"
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        permissionRequest()
    }

    //MARK: - Metods
    private func permissionRequest() {
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            if granted {
                print("Rec available")
            } else {
                print("Show settings")
                DispatchQueue.main.async {
                    self.showGoToSettingsAlert()
                }
            }
        }
    }

    private func showGoToSettingsAlert() {
        let alertController = UIAlertController (title: "Разрешить доступ", message: "Для работы диктовфона необходимо предоставить доступ к микрофону", preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    private func startRecording() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            voiceRecorder = try AVAudioRecorder(url: recordedFileUrl, settings: settings)
            voiceRecorder.delegate = self
            voiceRecorder.record()

            voiceRecView.setTitleRecButton("Stop")
        } catch {
            finishRecording(success: false)
        }
    }

    private func finishRecording(success: Bool) {
        voiceRecorder.stop()
        voiceRecorder = nil

        if success {
            voiceRecView.setTitleRecButton("Record")
        } else {
            voiceRecView.setTitleRecButton("Re-record")
            // recording failed :(
        }
    }

    private func checkingAvailability() {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        if status == .authorized {
            print("Rec available")
        } else {
            print("Show settings")
        }
    }

    private func layout() {
        view.addSubview(voiceRecView)

        voiceRecView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension VoiceRecController: VoiceRecViewDelegate {
    func didTapPlayButton() {
        let isPlayng = Player?.isPlaying ?? false
        if let _ = Player, isPlayng {
            playerStop()
        } else {
            playerPlay()
        }
    }

    func didTapRecButton() {
        if voiceRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }


}

extension VoiceRecController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}

extension VoiceRecController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying() {
        playerStop()
    }

    private func prepareToPlay() {
        do {
            Player = try AVAudioPlayer(contentsOf: recordedFileUrl)
            Player!.prepareToPlay()
            print("Длительность записи \(Player!.duration)")
        }
        catch {
            print(error)
        }
    }

    private func playerStop() {
        Player?.stop()
        Player = nil
        voiceRecView.setTitlePlayButton("Play")
    }

    private func playerPlay() {
        prepareToPlay()
        Player!.play()
        voiceRecView.setTitlePlayButton("Stop")
    }
}

