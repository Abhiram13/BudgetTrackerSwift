import UIKit;

func notify(message: String) {
    NotificationCenter.default.post(
        name: Notification.Name("com.bt.alert"),
        object: nil,
        userInfo: ["error": message]
    );
}
