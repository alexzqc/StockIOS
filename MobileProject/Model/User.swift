
import UIKit


struct Helper{
    static var CurrentUser : User?
}

class User: NSObject {
    var id : String?
    var name: String?
    var credit : Float?
    var stocks : [String: [Any]]?
    
    init(_ dictionary : [String: AnyObject]) {
        name = dictionary["name"] as? String
        credit = dictionary["balance"] as? Float
        stocks = dictionary["stocks"] as? [String:[Any]]
        print("")
    }
}
