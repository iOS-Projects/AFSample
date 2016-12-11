//
//  AddTableViewController.swift
//  AFSample
//
//  Created by Amreth on 12/11/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner


class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBAction func btnBrowse(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get image
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // Display image to imageview
        imgView.image = image
        // Dismiss ImagePickerController
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnSave(_ sender: Any) {
        
        SwiftSpinner.show("Image Uploading...")
        
        
        let img = self.imgView.image
        let imageData = UIImageJPEGRepresentation(img!, 1)
        let headers : HTTPHeaders = ["Authorization" :"Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]
        // Upload Image
        Alamofire.upload(multipartFormData: { formData in
            // Append Image to FormData
            formData.append(imageData!, withName: "FILE", fileName: "image.jpg", mimeType: "image/jpg")
            
        
        }, usingThreshold: 0, to: URL(string: UPLOAD_IMAGE_SINGLE)!, method: HTTPMethod.post, headers: headers, encodingCompletion: { result in
            
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { data in
                    SwiftSpinner.hide()
                    let dic = data.result.value as! NSDictionary
                    print(dic["DATA"])
                    // Start posting article
                    self.postArticle(imageUrl: dic["DATA"]! as! String)
                    
                })
                
            case .failure(let error):
                
                SwiftSpinner.show("Failed to connect, waiting...", animated: false)
                print(error.localizedDescription)
            }
            
        })
        
        // Post Article
    }
       func postArticle(imageUrl: String){
        SwiftSpinner.show("Posting Article...")
        let title = self.txtTitle.text
        let desc = self.txtDescription.text
        
        let param : Parameters = [
            "TITLE": title! as String,
            "DESCRIPTION": desc! as String,
            "AUTHOR": 0,
            "CATEGORY_ID": 0,
            "STATUS": "string",
            "IMAGE": imageUrl
        ]
        let headers : HTTPHeaders = ["Authorization" :"Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=", "Content-Type": "application/json"]
        Alamofire.request("http://120.136.24.174:1301/v1/api/articles", method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: {
            
            response in
            
            debugPrint(response)
            
            SwiftSpinner.hide()
        
        })
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    

    
}
