

import UIKit

class Cat: NSObject {
    struct CatCellInfo {
        let name : String!
        let image : UIImage!
        let age : Int!
        let type : String!
    }
    
    static var count : Int = 0
    static var catArr = [CatCellInfo]()
    
    class func addCat(catName : String!, catImage : UIImage, catAge : Int!, catType : String!) -> Void {
        catArr.append(CatCellInfo(name: catName, image: catImage, age: catAge, type: catType))
        count += 1
    }
    class func loadCats() -> Void {
        let url = URL(string: "https://chenziwe.com/cats")
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            if (error != nil){
                print("Failed to load cats!")
                return
            }
            print("Got our cats!")
            let result = try? JSONSerialization.jsonObject(with: data!, options: []) as! Array<Dictionary<String, String>>

            for dict in result! {
                let imageURL = URL(string: dict["image"]!)
                let image = UIImage(data: try! Data(contentsOf: imageURL!))
                Cat.addCat(catName: dict["name"]!, catImage: image!, catAge: Int(dict["age"]!), catType: dict["type"]!)
            }
        }
        task.resume()
    }
    
}
