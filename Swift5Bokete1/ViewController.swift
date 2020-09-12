//
//  ViewController.swift
//  Swift5Bokete1
//
//  Created by noguchi on 2020/09/12.
//  Copyright © 2020 noguchi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {

    
    
    @IBOutlet weak var odaiImageView: UIImageView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var searchTextView: UITextField!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentTextView.layer.cornerRadius = 20.0
        
        PHPhotoLibrary.requestAuthorization{ (status) in
        
        switch(status) {
            case .authorized: break
            case .denied: break
            case .notDetermined: break
            case .restricted: break
            
            
        }
    }

    }

    //検索キーワード
    //pixabay.com
    
    func getImages(keyword:String){
        
        //APIkey
        let url = "https://pixabay.com/api/?key=18277393-2d13279decb5bf1144e6a304b&q=\(keyword)"
        
        //Alamofireを使ってhttpリクエストを投げる。
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result{
                
            case .success:
                let json:JSON = JSON(response.data as Any)
                let imageString = json["hits"][self.count]["webformatURL"].string
                self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
            
            
            
            case .failure(let error):
                
                  print(error)
            
                
            }
            
        }

    }
  
    
    @IBAction func nextOdai(_ sender: Any) {
        
        
        
    }
    
    
    

}

