//
//  ViewController.swift
//  recipe
//
//  Created by Admin on 26/3/2562 BE.
//  Copyright © 2562 Admin. All rights reserved.
//

import UIKit
import Foundation


struct Recipe: Decodable {
    let title: String?
    let results: [Results]
}

struct Results: Decodable {
    let title: String?
    let href: String?
    let ingredients: String
    let thumbnail: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var TextViews: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TextViews.text = ""
        let jsonURLString = "http://www.recipepuppy.com/api/?i=onions,garlic&q=omelet&p=3"
        guard let urlObj = URL(string: jsonURLString) else {return}
        
        URLSession.shared.dataTask(with: urlObj) {(data, responds, err) in
            guard let data = data else {return}
            do {
                let countries = try JSONDecoder().decode(Recipe.self, from: data)
                
                for countrys in countries.results {
                    self.TextViews.text.append("Name : \(countrys.title!) \n")
                    self.TextViews.text.append("ingredients : \(countrys.ingredients) \n")
                }
                
            } catch {
                print(error)
            }
        }.resume()
    }

    
}

