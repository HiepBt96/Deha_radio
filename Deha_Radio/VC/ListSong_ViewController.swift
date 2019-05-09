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
    var databasehandle: DatabaseHandle!
    var listVideo: [Video] = [Video]()
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
        databasehandle = ref.observe(.value, with: { (snapshot) in
            if !snapshot.exists() { return }
            let videos = snapshot.value as! [String:Any]?
            let video = videos?["video"] as! [String:Any]?
            var list = [Video]()
            for key in Array((video?.keys)!){
                list.append(Video(dictionary: video![key] as! [String:AnyObject], key: key))
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
        let catPictureURL = URL(string: eachVideo.videothumbnails)
        Alamofire.request(catPictureURL!).response { (response) in
            if let response = response.data {
                cell.imgSong.image = UIImage(data: response)
            }
        }
        
      
       
        
//        func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//        }
//
//        func downloadImage(from url: URL) {
//            print("Download Started")
//            getData(from: url) { data, response, error in
//                guard let data = data, error == nil else { return }
//                print(response?.suggestedFilename ?? url.lastPathComponent)
//                print("Download Finished")
//                DispatchQueue.main.async() {
//                   // self.imageView.image = UIImage(data: data)
//                    cell.imgSong.image = UIImage(data: data)
//                }
//            }
//        }
//        downloadImage(from: catPictureURL)
        // Creating a session object with the default configuration.
        // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
//        let session = URLSession(configuration: .default)
//
//        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
//        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
//            // The download has finished.
//            if let e = error {
//                print("Error downloading cat picture: \(e)")
//            } else {
//                // No errors found.
//                // It would be weird if we didn't have a response, so check for that too.
//                if let res = response as? HTTPURLResponse {
//                    print("Downloaded cat picture with response code \(res.statusCode)")
//                    if let imageData = data {
//                        // Finally convert that Data into an image and do what you wish with it.
//                        cell.imgSong.image = UIImage(data: imageData)
//                        //let image = UIImage(data: imageData)
//                        // Do something with your image.
//                    } else {
//                        print("Couldn't get image: Image is nil")
//                    }
//                } else {
//                    print("Couldn't get response code for some reason")
//                }
//            }
//        }
//
//        downloadPicTask.resume()
        
        return cell
        
    }
    
    
}
