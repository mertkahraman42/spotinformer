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
    
    var searchQuery: String = ""
    var searchURL = ""
    
    func formatSeachQuery() {
        for var character in searchQuery.characters {
            if character == " " {
                character = "+"
            }
        }
        print("Formatted Search Query is \(searchQuery)")
    }
    
    func generateURL() {
        searchURL = "https://api.spotify.com/v1/search?q=\(self.searchQuery)&type=track&limit=20"
    }
    
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
                if let items = tracks["items"] {
                    
                    for i in 0..<items.count {
                        let item = items[i] as! JSONStandard
                        
                        let name = item["name"] as! String
                        
                        names.append(name)
                        
                        self.tableView.reloadData()
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
        
        return cell!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

