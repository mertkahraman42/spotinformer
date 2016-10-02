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
    
    var searchQueryTextInput: String = "" {
        didSet {
            print(searchQueryTextInput)
        }
    }
    
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
    

    // MARK: - Segue

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            if let searchVC = segue.destination as? TableViewController {
                searchVC.searchQuery = searchQueryTextInput
                searchVC.formatSeachQuery()
                searchVC.generateURL()
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
