//
//  SearchViewController.swift
//  AFSample4
//
//  Created by Mert Kahraman on 02/10/2016.
//  Copyright © 2016 Mert Kahraman. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
//    enum Error: Error {
//        case NoName
//        
//        init?(rawValue: Self.RawValue)
//    }

    @IBOutlet weak var searchTextField: UITextField!
    
    var searchQueryTextInput: String = ""
    var searchURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func searchField(_ sender: UITextField) {
        if let searchText = sender.text {
            searchQueryTextInput = searchText
        }
        
    }
    
    func generateURL() {
        let searchQuery = searchQueryTextInput.replacingOccurrences(of: " ", with: "+")
        searchURL = "https://api.spotify.com/v1/search?q=\(searchQuery)&type=track&limit=20"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            if let searchVC = segue.destination as? TableViewController {
                self.searchTextField.resignFirstResponder()
                generateURL()
                searchVC.searchURL = self.searchURL
                searchVC.fetchData()
            }
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
