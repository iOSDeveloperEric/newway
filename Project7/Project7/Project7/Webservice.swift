//
//  Webservice.swift
//  TableViewAPIData
//
//  Created by Sanjay Sadhu on 17/07/23.
//

import Foundation
import Alamofire
import UIKit
import SystemConfiguration

struct WebServiceFiles {
    let fileName: String?
    let image: UIImage?
    let fileURL: String?
}

class Webservice {
    
    /// HTTPClient Errors
    enum HTTPClientError: Error {
        case urlNotValid
        case genericError
    }
        
    //MARK: - API Calls Methods
//    private class func getHttpHeaders() -> HTTPHeaders {
//
//        var headers : HTTPHeaders = [:]
//        headers[APIHeaderKey.accept]                = "application/json"
//        headers[APIHeaderKey.contentType]           = "application/json"
//
//        headers[APIHeaderKey.versionNumber]         = getAppVersion()
//        headers[APIHeaderKey.deviceType]            = "1"
//
//        headers[APIHeaderKey.deviceToken]           = Constant.firebaseFCMToken
//        headers[APIHeaderKey.platformKey]           = WSClient.apiPlatFormKey
//
//        headers[APIHeaderKey.Authorization]         = "Bearer \(Constant.Models.loginDataModel?.headerToken ?? "")"
//        headers[APIHeaderKey.role]                  = "\(Constant.Models.loginDataModel?.currerntRoleSlug ?? "")"
//        return headers
//    }
    
    class func API<T: Codable>(_ strUrl: String,
                    methodType : HTTPMethod,
                    param: [String: Any]?,
                    encoding: ParameterEncoding = JSONEncoding.default,
                    responseModel: T.Type,
                    controller: UIViewController? = nil,
                    callSilently : Bool = false,
                    isDisplayAlertWhenError:Bool = true,
                    isRetryWhenTimeOut: Bool = false,
                    completionHandler: @escaping (Result<T, Error>) -> Void) {
        
        if Webservice.isNetworkAvailable() {
            
            ///URL
            guard let strURlForURL = strUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed),
                  let url = URL(string: strURlForURL) else {
                completionHandler(.failure(HTTPClientError.urlNotValid))
                displayError(isDisplayAlertWhenError: isDisplayAlertWhenError, error: HTTPClientError.urlNotValid as NSError, controlller: controller)
                return
            }
            
            ///Headers
//            var headers = Webservice.getHttpHeaders()
            
            debugPrint("API URL: --------------------------------------")
            debugPrint(strURlForURL)
//            debugPrint("API Headers: ----------------------------------")
//            debugPrint(headers)
            debugPrint("API Param: ------------------------------------")
            debugPrint(param ?? [:])
            
            ///Request
            let request = AF.request(url, method: methodType, parameters: param, encoding: encoding)
            
            request.response { (response) in
                if response.response?.statusCode == 401 {
                    completionHandler(.failure(HTTPClientError.genericError))
                } else if let data = response.data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        print("API URL: \(strUrl)\nAPI Result: \(jsonResponse)")
                        completionHandler(.success(try JSONDecoder().decode(responseModel, from: data)))
                    } catch {
                        completionHandler(.failure(error))
                        displayError(isDisplayAlertWhenError: isDisplayAlertWhenError, error: error as NSError, controlller: controller)
                    }
                } else if let error = response.error {
                    completionHandler(.failure(error))
                    displayError(isDisplayAlertWhenError: isDisplayAlertWhenError, error: error as NSError, controlller: controller)
                } else {
                    completionHandler(.failure(HTTPClientError.genericError))
                    displayError(isDisplayAlertWhenError: isDisplayAlertWhenError, error: HTTPClientError.genericError as NSError, controlller: controller)
                }
            }
            
        } else {
//            let errorInConnection = NSError(domain: "InternetNotAvailable", code: URLError.Code.notConnectedToInternet.rawValue, userInfo: nil)
            let errorInConnection = NSError(domain: "InternetNotAvailable", code: URLError.Code.notConnectedToInternet.rawValue, userInfo: [NSLocalizedDescriptionKey : "No Internet"])

            completionHandler(.failure(errorInConnection as Error))
            displayError(isDisplayAlertWhenError: isDisplayAlertWhenError, error: errorInConnection, controlller: controller)
        }
    }
    
    private class func getmimeType(strExtention:String) -> String {
        
        var strMimeType = ""
        
        switch strExtention {
        case "jpg"  : strMimeType = "image/jpg"
        case "jpeg" : strMimeType = "image/jpeg"
        case "png"  : strMimeType = "image/png"
        case "pdf"  : strMimeType = "application/pdf"
        case "csv"  : strMimeType = "application/csv"
        case "xls"  : strMimeType = "application/vnd.ms-excel"
        case "xlsx" : strMimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        case "mpeg" : strMimeType = "video/mpeg"
        case "mp4"  : strMimeType = "video/mp4"
        case "avi"  : strMimeType = "video/x-msvideo"
        case "wmv"  : strMimeType = "video/x-ms-wmv"
        case "mov"  : strMimeType = "video/quicktime"
        default: strMimeType = ""
        }
        
        return strMimeType
    }
    
    private class func displayError(isDisplayAlertWhenError:Bool, error: NSError,controlller: UIViewController?) {
//        guard let objVC = controlller else {
//            return
//        }
        switch error.code {
        case NSURLErrorTimedOut,NSURLErrorCancelled:
//            AlertViewClass.shared().alertSuccessErrorMessage(objVC.view, messageDetails: Text.SomeThingWentWrong)
            debugPrint("Timeout Error", error.code)
            return
        case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost, NSURLErrorTimedOut:
            debugPrint("networkConnectionLost Error", error.code)
//            AlertViewClass.shared().alertSuccessErrorMessage(objVC.view, messageDetails: "Internet connection is not available.")
            return
        default:
//            AlertViewClass.shared().alertSuccessErrorMessage(objVC.view, messageDetails: Text.SomeThingWentWrong)
            debugPrint("Timeout Error", error.code)
            break
        }
    }
    
}

//MARK: - Check Internet Connection

extension Webservice {
    class func isNetworkAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}
