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
            
        default:break
            
        }
    }

   getImages(keyword: "funny")





    }

    //検索キーワード
    //pixabay.com
    
    func getImages(keyword:String){
        
        //APIkey
        let url = "https://pixabay.com/api/?key=18277393-2d13279decb5bf1144e6a304b&q=\(keyword)"
        
        //Alamofireを使ってhttpリクエストを投げる。
        //値が返ってきて、それをJSON解析を行う
        //imageview.imageに貼り付ける
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result{
                
            case .success:
                let json:JSON = JSON(response.data as Any)
                var imageString = json["hits"][self.count]["webformatURL"].string
                
                if imageString == nil{
                    
                    imageString = json["hits"][0]["webformatURL"].string
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)

                }else{
                    
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                }
                
                
                
            
            
            
            case .failure(let error):
                
                  print(error)
            
                
            }
            
        }

    }
  
    
    @IBAction func nextOdai(_ sender: Any) {
        
        count = count + 1
        
        if searchTextView.text == ""{
            
            getImages(keyword : "funny")
            
        }else{
            
            getImages(keyword: searchTextView.text!)
            
        }
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.count = 0
        if searchTextView.text == ""{
            
            getImages(keyword : "funny")
            
        }else{
            
            getImages(keyword: searchTextView.text!)
            
        }
        
    }
    
    
    @IBAction func next(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVC = segue.destination as? ShareViewController
        
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
        
    }
    
    

}

