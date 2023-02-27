import UIKit;

protocol ObserverProtocol {
    static func fire(name: String, payload: [String: Any]) -> Void;
    static func subscribe(observer: Any, selector: Selector, name: String) -> Void;
}

class Observer: ObserverProtocol {
    static func fire(name: String, payload: [String : Any]) {
        NotificationCenter.default.post(
            name: Notification.Name(name),
            object: nil,
            userInfo: payload
        )
    }
    
    static func subscribe(observer: Any, selector: Selector, name: String) {
        NotificationCenter.default.addObserver(
            observer,
            selector: selector,
            name: Notification.Name(name),
            object: nil
        )
    }
}
