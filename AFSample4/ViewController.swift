//
//  ViewController.swift
//  AFSample4
//
//  Created by Mert Kahraman on 02/10/2016.
//  Copyright © 2016 Mert Kahraman. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    var names = [String]()
    var albums = [String]()
    var coverImages = [UIImage]()
    
    var searchURL = ""
    
    func fetchData() {
        callAlamo(url: searchURL)
    }
    
    typealias JSONStandard = [String : AnyObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func callAlamo(url: String) {
        Alamofire.request(url).responseJSON { response in // response will hold all the data coming in the form of JSON
        
            self.parseData(JSONData: response.data!)
        
        }
    }
    
    func parseData(JSONData: Data) {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let tracks = readableJSON["tracks"] as? JSONStandard {
               
                // Get the tracknames
                if let items = tracks["items"] {
                    for i in 0..<items.count {
                        let item = items[i] as! JSONStandard
                        
                        // Get track names
                        let name = item["name"] as! String
                        names.append(name)
                        self.tableView.reloadData()
                        
                        // Get album names
                        let albumItem = item["album"] as! JSONStandard
                        let albumName = albumItem["name"] as! String
                        albums.append(albumName)
                        
                        // TODO: Try to get the images on the User_Initiated thread
                        // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        // Get covers
                        var covers = albumItem["images"] as! [JSONStandard]
                        let cover64 = covers[2] 
                        let coverURL = URL(string: cover64["url"] as! String) ?? URL(fileURLWithPath: "")
                        let coverImage = UIImage(data: try Data(contentsOf: coverURL))
                        coverImages.append(coverImage!)
                        //}
                    }
                }
            }
        } catch {
            print (error)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = names[indexPath.row]
        cell?.detailTextLabel?.text = albums[indexPath.row]
        cell?.imageView?.image = coverImages[indexPath.row]
        
        return cell!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

