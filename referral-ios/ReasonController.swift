//
//  ReasonController.swift
//  referral-ios
//
//  Created by Bart Termorshuizen on 1/03/2018
//  Copyright © 2017 Bart Termorshuizen. All rights reserved.
//

import UIKit
import AVFoundation

class ReasonController: UIViewController, UITextViewDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    
   

    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var btnMicrophone: UIButton!
    @IBOutlet weak var mReason: UITextView!
    @IBOutlet weak var waveformView: SCSiriWaveformView!
    @IBOutlet weak var lblRecordedReason: UILabel!
    @IBOutlet weak var lblReason: UILabel!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer?
    var recordingEnabled: Bool!
    var recordingInProgress: Bool!
    var isRecordedReason: Bool!

    
    var referral : Referral?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mReason.delegate=self
        
        recordingSession = AVAudioSession.sharedInstance()
        recordingEnabled = false
        recordingInProgress = false
        
        self.navigationItem.title = "Reden verwijzing"
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.enableRecordingUI()
                        self.recordingEnabled = true
                    } else {
                        // failed to obtain permission
                        self.hideRecordingUI()
                        self.recordingEnabled = false
                    }
                }
            }
        } catch {
            // failed to create a recording session
        }
        
        do {
            try recordingSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
        } catch let error as NSError {
            print("Error when attempting to set audio port to speaker: \(error.localizedDescription)")
        }
        
        
        let borderColor = UIColor(red:204/255, green:204/255, blue:204/255, alpha:1.0)
        
        mReason.layer.borderColor = borderColor.cgColor;
        mReason.layer.borderWidth = 1.0;
        mReason.layer.cornerRadius = 5.0;
        referral = Referral()
        modelToView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewToModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        referral = Referral();
        modelToView();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }

    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
       colorLabelsWhenEmpty()
    }
    
    @objc func colorLabelWhenEmpty(_ label:UILabel, _ editText:UITextView){
        if (editText.text!.isEmpty){
            // set label text to accent color
            label.textColor = UIColor.init(red: 241/255, green: 90/255, blue: 49/255, alpha: 1)
        }
        else {
            // set label in gray color
            label.textColor = UIColor.darkGray
        }
    }
    
    
    @objc func colorLabelsWhenEmpty(){
        if (mReason.text!.isEmpty && !isRecordedReason){
            // if both empty, color both labels
            lblReason.textColor = UIColor.init(red: 241/255, green: 90/255, blue: 49/255, alpha: 1)
            lblRecordedReason.textColor = UIColor.init(red: 241/255, green: 90/255, blue: 49/255, alpha: 1)
        }
        else {
            // properly filled
            lblReason.textColor = UIColor.darkGray
            lblRecordedReason.textColor = UIColor.darkGray
        }
    }
    
    
    @IBAction func phoneClicked(_ sender: Any) {
        let busPhone = "0203080750"
        Call.callNumber(phoneNumber: busPhone)
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        referral!.clearReason()
        referral!.store()
        modelToView()
    }
    
    @IBAction func okClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func modelToView(){
        // copies the model in the view
        mReason.text = referral!.getReason()
        isRecordedReason = referral!.getIsRecordedReason()
        setRecordingUIState()
        colorLabelsWhenEmpty()
    }
    
    @objc func viewToModel() {
        // store the vet, place and name preferences to the model.
        referral!.setReason(reason: mReason.text)
        referral!.setIsRecordedReason(isRecordedReason: isRecordedReason)
        referral!.store();
    }
    
    @IBAction func recordClick(_ sender: UIButton) {
        // this button is either to "Record" or "Stop recording"
        
        if (recordingInProgress){
            // Stop recording
            debugPrint("Recording in progress -- stopping")
            finishRecording(success: true)
        }
        else {
            // start recording
            audioRecorder = nil;
            debugPrint("Recording not in progress -- starting")
            startRecording()
        }
    }
    func startRecording() {
        recordingInProgress = true
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.record()
            waveformView.isHidden=false
            let displayLink:CADisplayLink = CADisplayLink(target: self, selector: #selector (updateWaveFormRecordingAndTime))
            displayLink.add(to:.current, forMode: .defaultRunLoopMode)
            
            // change record button to stop button
            setRecordButtonToStop()
            setRecordingUIState()
            colorLabelsWhenEmpty()
        } catch {
            finishRecording(success: false)
        }
    }
    
    @objc func updateWaveFormRecordingAndTime(displaylink: CADisplayLink) {
        audioRecorder.updateMeters()
        let normalizedValue:CGFloat = pow(10, CGFloat(audioRecorder.averagePower(forChannel:0))/20)
        waveformView.update(withLevel: normalizedValue)
        
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        recordingInProgress = false;
        if success {
            // change record button to record button
            setRecordButtonToRecord()
            isRecordedReason=true
            setRecordingUIState()
            colorLabelsWhenEmpty()
        } else {
            // recording failed
            // change record button to record button
            setRecordButtonToRecord()
            isRecordedReason=false
            setRecordingUIState()
            colorLabelsWhenEmpty()
        }
        
    }
    
    func setRecordButtonToStop(){
        if let image = UIImage(named: "stop") {
            self.btnRecord.setImage(image, for: .normal)
        }
    }
    func setRecordButtonToRecord(){
        if let image = UIImage(named: "record") {
            self.btnRecord.setImage(image, for: .normal)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    @IBAction func playClick(_ sender: UIButton) {
        if (recordingInProgress){
            debugPrint("Recording in progress -- stopping before playing")
            finishRecording(success: true)
        }
        
        if isRecordedReason {
            debugPrint("Playing recording")
            
            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
            do {
                waveformView.isHidden = false
                audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
                
                audioPlayer?.delegate = self
                audioPlayer?.isMeteringEnabled = true
                audioPlayer?.play()
                let displayLink:CADisplayLink = CADisplayLink(target: self, selector: #selector (updateWaveFormPlaying))
                displayLink.add(to:.current, forMode: .defaultRunLoopMode)
                
            } catch {
                // couldn't load file :(
            }
        }
        else{
            debugPrint("Nothing to play")
        }
    }
    
    @objc func updateWaveFormPlaying(displaylink: CADisplayLink) {
        if (audioPlayer != nil){
            audioPlayer?.updateMeters()
            let normalizedValue:CGFloat = pow(10, CGFloat(audioPlayer!.averagePower(forChannel:0)/20))
            waveformView.update(withLevel: normalizedValue)
            
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        waveformView.isHidden = true
    }
    
    
    @IBAction func removeClick(_ sender: UIButton) {
        if (recordingInProgress){
            debugPrint("Recording in progress -- stopping before removing")
            finishRecording(success: true)
        }
        
        if (audioRecorder != nil ){
            debugPrint("Removing recording")
            isRecordedReason=false
            setRecordingUIState()
            colorLabelsWhenEmpty()
            do {
                try FileManager.default.removeItem(at: audioRecorder.url)
            } catch let error as NSError {
                print("Error: \(error.domain)")
            }
        }
        else {
            // previously recorded
            debugPrint("Removing previously stored recording")
            isRecordedReason=false
            setRecordingUIState()
            colorLabelsWhenEmpty()
            do {
                try FileManager.default.removeItem(at: getDocumentsDirectory().appendingPathComponent("recording.m4a"))
            } catch let error as NSError {
                print("Error: \(error.domain)")
            }
        }
    }
    
    @objc func enableRecordingUI(){
        // to be implemented
    }
    
    @objc func showRecordingUI(){
        btnMicrophone.isEnabled = false
        btnRecord.isHidden = false
        btnPlay.isHidden = false
        btnRemove.isHidden = false
        setRecordingUIState()
    }
    
    @objc func hideRecordingUI(){
        btnMicrophone.isEnabled = true
        btnRecord.isHidden = true
        btnPlay.isHidden = true
        btnRemove.isHidden = true
        waveformView.isHidden = true
    }
    
    func setRecordingUIState(){
        if (recordingInProgress){
            btnMicrophone.isEnabled = false
            waveformView.isHidden=false
            btnPlay.isEnabled = false
            btnRemove.isEnabled=false
        }
        else if (isRecordedReason){
            btnMicrophone.isEnabled = true
            waveformView.isHidden = true
            btnPlay.isEnabled = true
            btnRemove.isEnabled=true
        }
        else { // no recording in progress and there is no recording
            btnMicrophone.isEnabled = false
            waveformView.isHidden=true
            btnPlay.isEnabled = false
            btnRemove.isEnabled=false
        }
    }
    
}

