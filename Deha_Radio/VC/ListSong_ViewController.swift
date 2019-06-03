//
//  ListSong_ViewController.swift
//  Deha_Radio
//
//  Created by Bui The Hiep on 4/23/19.
//  Copyright © 2019 BuiTheHiep. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Alamofire

class ListSong_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ref: DatabaseReference!
    //var databasehandle: DatabaseHandle!
    var listVideo: [Video] = [Video]()
    var selectedVideo: Video?
    //var listAllVideo: [Video] = [Video]()
    @IBOutlet weak var tblLitSong: UITableView!
    @IBOutlet weak var lblVideoname: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblLitSong.dataSource = self
        tblLitSong.delegate = self
        ref = Database.database().reference()   // set the firebase reference
        
        //Set the selected icons and text tint color
        self.tabBarController?.tabBar.tintColor = UIColor.orange
        
        //Generate color tab bar
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "background.png")!)
        
        // Read data from Firebase
         self.ref.child("video").queryOrdered(byChild: "Timestamp").observe(.value, with: { (snapshot) in
            if !snapshot.exists() { return }
            let videos = snapshot.value as! [String:Any]?
            //let video = videos?["video"] as! [String:Any]?
            var list = [Video]()
            if let keys = videos?.keys {
                for key in Array(keys){
                    list.append(Video(dictionary: videos![key] as! [String:AnyObject], key: key))
                }
            }
            self.listVideo = list
            self.tblLitSong.reloadData()
        })

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return listVideo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemSong_TableViewCell
        let eachVideo = listVideo[indexPath.row]
        cell.imgSong.layer.borderWidth = 1
        cell.imgSong.layer.cornerRadius = 10
        cell.imgSong.layer.masksToBounds = true
        cell.txtSongname.text = eachVideo.videoTitle
        cell.txtDescrible.text = eachVideo.Massage
        guard let videoThumbnails = eachVideo.videothumbnails else { return cell }
        if let catPictureURL = URL(string: videoThumbnails)
        {
            Alamofire.request(catPictureURL).response { (response) in
                if let response = response.data {
                    cell.imgSong.image = UIImage(data: response)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVideo = listVideo[indexPath.row]
        //listAllVideo = listVideo
        self.tabBarController!.selectedIndex = 1
        let playViewController = self.tabBarController?.viewControllers![1] as! Played_Video_ViewController
        playViewController.selectedVideo = self.selectedVideo
       // playViewController.listAllVideo = self.listAllVideo
    }
}
