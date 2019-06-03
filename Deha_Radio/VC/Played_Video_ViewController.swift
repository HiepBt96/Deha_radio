//
//  Played_Video_ViewController.swift
//  Deha_Radio
//
//  Created by Bui The Hiep on 5/8/19.
//  Copyright © 2019 BuiTheHiep. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class Played_Video_ViewController: UIViewController {
    //var listAllVideo : [Video] = [Video]()
    var selectedVideo : Video?
    var idVideoSlected:String?
    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var txtMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        //playerView.load(withVideoId: "ph2ISJx-gYs")
    }
    override func viewDidAppear(_ animated: Bool) {
        if let vid = self.selectedVideo{
            idVideoSlected = vid.videoID
            playerView.load(withVideoId: idVideoSlected!, playerVars: ["playsinline" : 1])
        }else{
            txtMessage.text = "Không có video được chọn"
            txtMessage.textColor = UIColor.red
        }
        
    }
}
