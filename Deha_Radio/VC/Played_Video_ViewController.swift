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

    @IBOutlet weak var playerView: WKYTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.load(withVideoId: "ph2ISJx-gYs")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
