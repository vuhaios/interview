//
//  ViewController.swift
//  Interview
//
//  Created by Vuha on 14/11/18.
//  Copyright © 2018 Vuha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let message = "This is my message for the interview"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnShowAlertTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Warning !!", message: ViewController.message , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    // this shows the alert view, which is deprecated with iOS 9.0
    @IBAction func btnAlertViewTapped(_ sender: Any) {
        
        let alert = UIAlertView()
        alert.title = "Warning !!"
        alert.message = ViewController.message
        alert.addButton(withTitle: "Ok")
        alert.show()

    }
    
    // download function.
    @IBAction func btnDownloadTapped(_ sender: UIButton) {
        let urlString = "https://icdn1.digitaltrends.com/image/iphone-8-update-in-hand-logo-640x640.jpg"
        
        let url = URL.init(string: urlString)
        
        self.downloadFile(url: url!) { (filePath, error) in
            // downloaded path
            print(filePath ?? "")
        // you can view the download file in the path
        }
    }
    
    
    func downloadFile(url: URL, completionHandler: @escaping (String?, Error?) -> Void){
        
        let documentsPath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)

        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let downloadTask = session.dataTask(with: request) { (data, response, error) in
            
            if error == nil
            {
                        if let data = data
                        {
                            if let _ = try? data.write(to: destinationURL, options: Data.WritingOptions.atomic)
                            {
                                completionHandler(destinationURL.path, error)
                            }
                            else
                            {
                                completionHandler(destinationURL.path, error)
                            }
                        }
                        else
                        {
                            completionHandler(destinationURL.path, error)
                        }
            }
            else
            {
                completionHandler(destinationURL.path, error)
            }
        }
        downloadTask.resume()
    }
}

