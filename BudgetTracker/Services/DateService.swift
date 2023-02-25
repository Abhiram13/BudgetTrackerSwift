import UIKit;

/// More format information can be [found here:] (https://nsdateformatter.com/#reference)
enum DateFormats: String {
    /// Example: Saturday, Feb 11, 2023
    case dayWithDate = "EEEE, MMM d, yyyy";
    
    /// Example: 02/24/2023
    case americanDate = "MM/dd/yyyy";
    
    /// Example: Feb 11, 11:11 AM
    case shortDateWithTimePeriod = "MMM d, h:mm a";
    
    /// Example: Feb 11, 2023
    case onlyDate = "MMM d, yyyy";
    
    /// Example: 2023-02-27 05:59:00 +0000
    case longDateWithTime = "yyyy-MM-dd HH:mm:ss"
}

public class DateController {
    private static let dateFormatter = DateFormatter();
    
    static func convertToDate(date: String, to format: DateFormats = .longDateWithTime) -> Date {
        dateFormatter.dateFormat = format.rawValue;
        let date = dateFormatter.date(from: date);
        return date!;
    }
    
    static func convertToString(date: Date, to format: DateFormats = .longDateWithTime) -> String {
        dateFormatter.dateFormat = format.rawValue;
        return dateFormatter.string(from: date);
    }
}
