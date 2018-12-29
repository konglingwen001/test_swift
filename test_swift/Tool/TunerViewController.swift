//
//  TunerViewController.swift
//  test_swift
//
//  Created by 孔令文 on 2018/7/28.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import UIKit
import AVFoundation
import AudioKit

class TunerViewController: UIViewController ,AVAudioRecorderDelegate{
    
    var audioRecorder:AVAudioRecorder? = nil
    var audioPlayer:AVAudioPlayer? = nil
    var filePath:URL? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        filePath = getSavedFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startRecord(_ sender: Any) {
    }
    
    @IBAction func stopRecord(_ sender: Any) {
    }
    @IBAction func continueRecord(_ sender: Any) {
    }
    @IBAction func pauseRecord(_ sender: Any) {
    }
    
    func setAudioSession() {
        
    }
    
    func getSavedFile() -> URL {
        var urlStr:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        NSLog(urlStr)
        let fileManager = FileManager();
        if (fileManager.fileExists(atPath: urlStr)) {
            NSLog("file existed")
        } else {
            NSLog("file not existed")
        }
        urlStr = urlStr + "/test.pcm"
        let url = URL(fileURLWithPath: urlStr)
        return url
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
