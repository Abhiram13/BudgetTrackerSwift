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
}
