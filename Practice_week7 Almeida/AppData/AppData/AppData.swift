import Foundation

class AppData {
    
    public static let shared = AppData()
    
    private var dict: [String: Any] = [:]
    
    let barrierQueue : DispatchQueue = DispatchQueue (label: "barrierQueuestop " , attributes: .concurrent)
        
    private init(){ }

    public func set(value: Any, key: String) {
        barrierQueue.sync(flags: .barrier) {
            dict[key] = value
        }
        
    }

    public func object(key: String) -> Any? {
        barrierQueue.sync(flags: .barrier) {
            dict[key]
         
        }
        
    }

    public func reset(){
        dict.removeAll()
    }
}
