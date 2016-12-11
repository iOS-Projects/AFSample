//
//  ViewController.swift
//  AFSample
//
//  Created by Amreth on 12/9/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher

class TableViewController: UITableViewController {

    var arrayArticle = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getArticle()
    }

    func getArticle(){
        // Create Header
        let headers : HTTPHeaders = ["Authorization" :"Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]
        // Create REqeust URL
        let url = URL(string: "http://120.136.24.174:1301/v1/api/articles?page=1&limit=15")
        // Request (go to alamofire git hub then find HTTP Header, then copy "Alamofire.request("https://httpbin.org/headers", headers: headers)"; because we use almofire so that we need to response data as object therefore go to alamofire object mapper git hub to see how they next; we can find the way they write in Keypath; then write ".responseArray" after the code that we have copy "
        Alamofire.request(url!, headers: headers).responseArray(queue: DispatchQueue.main, keyPath: "DATA", context: nil, completionHandler: {(response:DataResponse<[Article]>) -> Void in
            
            self.arrayArticle = response.result.value!
            self.tableView.reloadData()
            for arr in self.arrayArticle{
                print("Title : \(arr.title!)")
                
            }
            
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayArticle.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let row = indexPath.row
        let arr = arrayArticle[row]
        cell.title.text = arr.title
        cell.author.text = arr.author?.name
        cell.textview.text = arr.description
        let url = URL(string: arr.image!)
        cell.img.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        
        return cell
        
    }
    
}

