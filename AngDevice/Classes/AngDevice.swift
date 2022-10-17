
import UIKit

open class AngDevice {
    
    public typealias DeviceType = (modelName: String, deviceFamily: DeviceFamily, systemName: String, version: String)
    
    public enum DeviceFamily{
        case phone
        case pod
        case pad
        case appletv
        case simulator
        case unknown
        
        public var isPad: Bool{
            return UIDevice.current.userInterfaceIdiom == .pad
        }
        
        public var isPhone: Bool{
            return UIDevice.current.userInterfaceIdiom == .phone
        }
        
    }

    public static let current: AngDevice = AngDevice()
    
    public var deviceType: DeviceType = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        let r_identifier: String = {
            
            switch identifier {
            case "iPod5,1":                                 return "iPodTouch5"
            case "iPod7,1":                                 return "iPodTouch6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone4"
            case "iPhone4,1":                               return "iPhone4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone5s"
            case "iPhone7,2":                               return "iPhone6"
            case "iPhone7,1":                               return "iPhone6+"
            case "iPhone8,1":                               return "iPhone6s"
            case "iPhone8,2":                               return "iPhone6s+"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone7+"
            case "iPhone8,4":                               return "iPhoneSE"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPadAir"
            case "iPad5,3", "iPad5,4":                      return "iPadAir2"
            case "iPad6,11", "iPad6,12":                    return "iPad5"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPadMini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPadMini2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPadMini3"
            case "iPad5,1", "iPad5,2":                      return "iPadMini4"
            case "iPad6,3", "iPad6,4":                      return "iPadPro97Inch"
            case "iPad6,7", "iPad6,8":                      return "iPadPro129Inch"
            case "iPad7,1", "iPad7,2":                      return "iPadPro129Inch2"
            case "iPad7,3", "iPad7,4":                      return "iPadPro105Inch"
            case "AppleTV5,3":                              return "AppleTV"
            case "i386", "x86_64":                          return "Simulator"
            default:                                        return identifier
            }
            
        }()

        let deviceFamily: DeviceFamily = {
            if      identifier.lowercased().contains("ipad") {return .pad}
            else if identifier.lowercased().contains("iphone") {return .phone}
            else if identifier.lowercased().contains("ipod") {return .pod}
            else if identifier.lowercased().contains("tv") {return .appletv}
            else if identifier.lowercased().contains("simulator") {return .simulator}
            else {return .unknown}
        }()
        
        return (r_identifier,deviceFamily,UIDevice.current.systemName,UIDevice.current.systemVersion)
        
    }()
}
