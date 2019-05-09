//
//  Video.swift
//  Deha_Radio
//
//  Created by Bui The Hiep on 5/4/19.
//  Copyright © 2019 BuiTheHiep. All rights reserved.
//

import UIKit

class Video: NSObject {

    var key:String
    var videoTitle:String
    var videothumbnails:String
    var videoID:String
    var Massage:String
    
    init(dictionary:[String:Any], key:String){
        self.key = key
        self.videoTitle = dictionary["videoTitle"] as! String
        self.videothumbnails = dictionary["videothumbnails"] as! String
        self.Massage = dictionary["masage"] as! String
        self.videoID = dictionary["videoID"] as! String
    }
}
