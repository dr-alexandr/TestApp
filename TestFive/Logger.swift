//
//  Logger.swift
//  TestFive
//
//  Created by Dr.Alexandr on 23.12.2022.
//

import Foundation

enum NetworkError: String, Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case noNetwork = "Please check your internet connection."
    case badResponse = "No response, please check your internet."
    case limit = "API rate limit exceeded."
}

enum LogEvent: String {
    case e = "[‼️]" // error
    case i = "[ℹ️]" // info
    case d = "[💬]" // debug
    case v = "[🔬]" // verbose
    case w = "[⚠️]" // warning
    
    var value: String {
        get {
            return self.rawValue;
        }
    }
}

class Log {
    
    deinit {
        print("Deallocation \(self)")
    }
    fileprivate static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
        df.locale = Locale.current
        df.timeZone = TimeZone.current
        return df
    }()
    
    private static var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    class func e( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.e.value)[\(sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)");
        }
    }
    
    class func i( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.i.value)[\(sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)");
        }
    }
    
    class func d( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.d.value)[\(sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)")
        }
    }
    
    class func v( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.v.value)[\(sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)")
        }
    }
    
    class func w( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.w.value)[\(sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)")
        }
    }
    
    
    private class func sourceFileName(filePath: String) -> String {
        if let last = filePath.components(separatedBy: "/").last {
            return last
        }
        return ""
    }
}

private extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
}

