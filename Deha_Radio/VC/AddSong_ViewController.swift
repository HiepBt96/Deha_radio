//
//  AddSong_ViewController.swift
//  Deha_Radio
//
//  Created by Bui The Hiep on 4/26/19.
//  Copyright © 2019 BuiTheHiep. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseDatabase



class AddSong_ViewController: UIViewController, UITextViewDelegate {
    
    var ref: DatabaseReference!
    let urlYoutubeAPIString:String = "https://www.googleapis.com/youtube/v3/videos"
    let APIKey:String = "AIzaSyDgpuJS0oZs639hTfmre98wAklZeXaDkIU"
    var array = [Video]()
    @IBOutlet weak var txtLink: UITextField!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnAdSongOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference() // set the firebase reference
        txtMessage.delegate = self
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "background.png")!)
        btnAdSongOutlet.layer.borderColor = UIColor.white.cgColor
        btnAdSongOutlet.layer.borderWidth = 1
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        txtMessage.text = "Lời Nhắn"
        txtMessage.textColor = UIColor.lightGray
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.txtLink.frame.height))
        txtLink.leftView = paddingView
        txtLink.leftViewMode = UITextField.ViewMode.always
        txtMessage.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        
    }
    
    func getYoutubeId(youtubeUrl: String) -> String? {
        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
    
    @IBAction func btnAdSongAction(_ sender: Any) {
        
        if (txtLink.text?.isEmpty)! {
            displayAlert(massage: "Link không được để trống")
        }
        else
        {
            let headers: HTTPHeaders =
                [
                    "Content-Type": "application/json"
            ]
            
            let idVideo:String = getYoutubeId(youtubeUrl: txtLink.text!)!  // get id video from URL
            
            Alamofire.request(urlYoutubeAPIString, method: .get, parameters: ["part":"snippet","id": idVideo ,"key": APIKey ], encoding: URLEncoding.default , headers:headers).responseJSON { (response) in
                if let Json = response.result.value as! [String:Any]?
                {
                    for item in Json["items"] as! NSArray
                    {
                        
                        let videoTitle = (item as AnyObject).value(forKeyPath: "snippet.title") as! String
                        let videothumbnails = (item as AnyObject).value(forKeyPath: "snippet.thumbnails.standard.url") as! String
                        let videoId = (item as AnyObject).value(forKeyPath: "id") as! String
                        let masage = self.txtMessage.text!
                        var Timestamp: TimeInterval {
                            return NSDate().timeIntervalSince1970 * 1000
                        }
                       
                        self.ref.child("video").childByAutoId().setValue(["videoTitle":videoTitle,"videoID":videoId,"videothumbnails": videothumbnails,"masage": masage,"Timestamp":Timestamp])
                        
                    }
                    self.navigationController?.popViewController(animated: true) // back to list song
                }
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        
        if self.txtMessage.textColor == UIColor.lightGray
        {
            self.txtMessage.text = nil
            self.txtMessage.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n"
        {
            txtMessage.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if txtMessage.text.isEmpty
        {
            txtMessage.text = "Lời Nhắn"
            txtMessage.textColor = UIColor.lightGray
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        txtLink.endEditing(true)
        txtMessage.endEditing(true)
    }
    
    func displayAlert (massage: String){
        let alert = UIAlertController(title: "Alert", message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
