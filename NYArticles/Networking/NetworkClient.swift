//
//  NetworkClient.swift
//  iOSMusicApp
//
//  Created by Hem Sharma on 04/07/18.
//  Copyright © 2018 Hem Sharma. All rights reserved.
//

import UIKit

typealias CompletionBlock = (_ response: Any?, _ error: NSError?) -> Void

class NetworkClient: NSObject
{
    static let sharedInstance = NetworkClient()
    
    private override init()
    {
        super.init()
    }
    
    func getDataFor(url:URL, responseType:ApiResponseType = .json, completionHandler: @escaping CompletionBlock)
    {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        self.networkCallFor(request: request, responseType: responseType, completionBlock: completionHandler)
    }
    
    fileprivate func networkCallFor(request:URLRequest, responseType:ApiResponseType , completionBlock: @escaping CompletionBlock)
    {
        var newRequest = request
        newRequest.timeoutInterval = 120
        newRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        URLSession.shared.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: newRequest, completionHandler:
        {
            (data, response, error) in
            
            DispatchQueue.main.async
                {
                    var receivedResponse:Any?
                    var customError : NSError? = nil
                    
                    if let receivedData = data
                    {
                        if responseType == .html
                        {
                            do{
                                let htmlString = try NSMutableAttributedString(data: data!,
                                                                        options: [.documentType : NSAttributedString.DocumentType.html],
                                                                        documentAttributes: nil)
                                receivedResponse = htmlString
                            }
                            catch
                            {
                                customError = NSError.init(domain: "", code: -2, userInfo: ["description" : "Could not create HTML string from url"])
                            }
                        }
                        else if responseType == .json
                        {
                            do
                            {
                                let jsonResponse = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments)
                                receivedResponse = jsonResponse
                            }
                            catch
                            {
                                //Data could not be converted to JSON
                                customError = NSError.init(domain: "", code: -1, userInfo: ["description" : "Data could not be converted to JSON"])
                                
                            }
                        }
                    }
                    else if let httpResponse = response as? HTTPURLResponse
                    {
                        let statusCode = httpResponse.statusCode
                        customError = NSError.init(domain: "", code: statusCode, userInfo: ["description" : "Invalid Response"])
                    }
                    else
                    {
                        customError = error as NSError?
                    }
                    
                    completionBlock(receivedResponse, customError)
            }
        })
        
        task.resume()
    }
    
}

extension NetworkClient : URLSessionDelegate
{
    
}
