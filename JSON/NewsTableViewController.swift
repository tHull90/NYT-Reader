//
//  NewsTableViewController.swift
//  JSON
//
//  Created by Timothy Hull on 6/27/17.
//  Copyright © 2017 Sponti. All rights reserved.
//

import UIKit
import SwiftyJSON
import WebKit
import Alamofire

class NewsTableViewController: UITableViewController {

    let nyTimesURL = "https://api.nytimes.com/svc/topstories/v1/business.json?api-key=f4bf2ee721031a344b84b0449cfdb589:1:73741808"
    var headlines = [String]()
    var abstracts = [String]()
    var images = [String]()
    var urls = [URL]()
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        getJSON()
        
        var titleView : UIImageView
        let frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        titleView = UIImageView(frame: frame)
        titleView.contentMode = .scaleAspectFit
        titleView.image = UIImage(named: "NYTLogo")
        
        self.navigationItem.titleView = titleView
    }
    
    
    
    
    func getJSON() {
        
        Alamofire.request(nyTimesURL).responseJSON { response in
            
            if response.result.value != nil {
                let json = JSON(response.result.value!)  // Convert the responseJSON to SwiftyJSON
                let results = json["results"].arrayValue   // Get the results as an array
                
                for result in results {   // Loop through the results for the pieces of data we want
                    
                    let headlines = result["title"].stringValue
                    let abstracts = result["abstract"].stringValue
                    let images = result["multimedia"][0]["url"].stringValue
                    let urls = result["url"].url
                    
                    // Add each value to the empty arrays we set up
                    self.headlines.append(headlines)
                    self.abstracts.append(abstracts)
                    self.images.append(images)
                    self.urls.append(urls!)
                }
                
                // Reload the data on the main thread (always update the UI on the main thread)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    
    

    
// MARK: - Tableview methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JSONcell", for: indexPath) as! JSONTableViewCell
        
        cell.cellLabel.text = self.headlines[indexPath.row]
        cell.cellDetailText.text = self.abstracts[indexPath.row]
        cell.cellImageView.loadImageUsingCacheWithUrlString(self.images[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        webView.load(URLRequest(url: self.urls[indexPath.row]))
        webView.allowsBackForwardNavigationGestures = true
        view = webView
        
        // Back button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.goBack))
    }
    
    func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }



}
