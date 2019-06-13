//
//  ViewController.swift
//  TEST
//
//  Created by Stratagile on 29/05/19.
//  Copyright © 2019 ramsheer. All rights reserved.
//

import UIKit

struct Picklist : Encodable {
    var AuthToken = String()
    var PostId = Int()
    var PostTitle = String()
    var Description = String()
    var PostStatus = Int()
}

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var reslt = ResultObject()
    var hasDAta = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actvityController(status: hasDAta)
        
        
        
        
        let myID = Picklist.init(AuthToken: "6i5joU0MLWOvR23GnkWOd1sUGJMvxQgA5Da9Gc3RFGkGdIKBpk", PostId: 516, PostTitle: "RAMS TEST", Description: "hiiiiiiiiiiiiiiiiiiiiiiiii", PostStatus: 0)
        let url = "http://ec2-52-33-231-40.us-west-2.compute.amazonaws.com/associations/api/editpost"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(myID)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            print("ERROR")
        }
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                return
            }
            guard let data = data else { return }
            do{
                self.reslt =  try JSONDecoder().decode(ResultObject.self, from: data)
                print("result is", self.reslt)
                
                if (self.reslt.IsSuccess!){
                    if let mes = self.reslt.Message?.Text![0]{
                        DispatchQueue.main.async {
                            self.label.text = mes                        }
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        self.label.text = "error"
                        self.hasDAta = true

                    }
                }
            }catch{
                self.hasDAta = false
                print("error")
            }
        }
        task.resume()
    }
    func actvityController(status: Bool){

        let activityIndicator = UIActivityIndicatorView(style: .gray)
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
       
        if(!status){
            activityIndicator.startAnimating()
            
        }else{
            activityIndicator.stopAnimating()

        }
    }
}

