//
//  ViewController.swift
//  TEST
//
//  Created by Stratagile on 29/05/19.
//  Copyright © 2019 ramsheer. All rights reserved.
//

import UIKit
import CoreData


struct Picklist : Encodable {
    var AuthToken = String()
    var PostId = Int()
    var PostTitle = String()
    var Description = String()
    var PostStatus = Int()
}

class ViewController: UIViewController {
    @IBOutlet weak var activityIndctr: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    var reslt = ResultObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndctr.startAnimating()
  
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
                self.activityIndctr.isHidden = true
                self.label.text = "error"

                return
            }
            guard let data = data else { return }
            do{
                self.reslt =  try JSONDecoder().decode(ResultObject.self, from: data)
                print("result is", self.reslt)
                
                if (self.reslt.IsSuccess!){
                    if let mes = self.reslt.Message?.Text![0]{
                        DispatchQueue.main.async {
                            self.label.text = mes
                            self.activityIndctr.stopAnimating()
                            self.activityIndctr.isHidden = true

                        }
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        self.activityIndctr.stopAnimating()
                        self.activityIndctr.isHidden = true
                        self.label.text = "error"

                    }
                }
            }catch{
                print("error")
            }
        }
        task.resume()
    }
    
    
    
    func addToCoredata(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Ajmal", in: context) as! Ajmal
        
       entity.name = "ramsheer"
        entity.age = 22
    }
//    func clearBannerData(){
//
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        do{
//            let  doaDB = try context.fetch(Banners.fetchRequest())
//            for db in doaDB{
//                context.delete(db as! NSManagedObject)
//            }
//            try(context.save())
//        }
//        catch
//        {
//            print(error)
//        }
//    }
    
//    @objc func fetchWaktuSolat(){
//
//        print("reached fetchwaktu solat Appdelegate")
//
//        if let statetoPass = UserDefaults.standard.object(forKey: "state"){
//            let monthAndYear = self.getArabicDAy(dateformat: "MMMM yyyy")
//            let Day = self.getArabicDAy(dateformat: "dd")
//            let dictInfo = ["TarikhDate": monthAndYear,
//                            "State": statetoPass,"Date": Day]
//            print("TarikhDate",monthAndYear)
//            print("Date",Day)
//
//            let params:Parameters = ["WaktusulatTimings": dictInfo]
//
//            Alamofire.request("http://13.250.216.192/api/WaktusulatTimings", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
//                switch response.result {
//                case .success(let data):
//                    let jsonResponse: JSON = JSON(data)
//                    //  print("waktusolat timings",data)
//                    var myResponse : JSON = []
//                    myResponse = jsonResponse["Table_0"]
//                    print("The Response is:", myResponse)
//                    print(myResponse.count)
//                    for i in 0..<myResponse.count {
//
//                        let dict = SolatTimingClass(solatTimingsDetails: myResponse[i])
//                        self.solatTime.append(dict)
//                    }
//                    
//                    self.savePrayerTimes()
//
//                    break
//                case .failure(let error):
//
//                    print(error)
//                    print("connection error")
//                }
//            }
//        }else{
//            print("NO STATE sELETED")
//        }
//    }
//
    
}

