//
//  SoundTableViewCell.swift
//  Urban Dic
//
//  Created by Maimaitiming Abudukadier on 1/24/16.
//  Copyright © 2016 Maimaitiming Abudukadier. All rights reserved.
//

import UIKit
import AVFoundation

var player = AVAudioPlayer()

class SoundTableViewCell: UITableViewCell, AVAudioPlayerDelegate {
    var url:NSURL = NSURL()
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageViewplayerStatus: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func playSound() {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, rep, err) -> Void in
            if err == nil {
                if err == nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        do {
                            player = try AVAudioPlayer(data: data!)
                            if player.playing == true {
                               player.stop()
                                self.imageViewplayerStatus.image = UIImage(named: "play")
                                return
                            }
                        } catch let err  {
                            print(err)
                            return
                        }
                        player.prepareToPlay()
                        self.imageViewplayerStatus.image = UIImage(named: "pause")
                        self.activityIndicator.stopAnimating()
                        player.volume = 1
                        player.delegate = self
                        player.play()
                    })
                }
            }
            }.resume()
    }

    func stopPlaySound(){
        imageViewplayerStatus.image = UIImage(named: "play")
        player.stop()
        self.setSelected(false , animated: true)
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        imageViewplayerStatus.image = UIImage(named: "play")
        self.setSelected(false , animated: true)
    }

}
