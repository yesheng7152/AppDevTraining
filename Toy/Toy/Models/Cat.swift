

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
}
