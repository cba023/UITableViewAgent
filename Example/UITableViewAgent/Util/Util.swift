//
//  Util.swift
//  TableViewAgent_Example
//
//  Created by bo.chen on 2021/6/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class Util {
    
    static func getJsonData(from jsonPath: String, fileType: String) -> Dictionary<String, AnyObject>? {
        let path = Bundle.main.path(forResource: jsonPath, ofType: fileType)
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let jsonDic = jsonData as! Dictionary<String, AnyObject>
            return jsonDic;
        } catch let error as Error? {
            print("Local json reading error:",error!)
        }
        return nil
    }
    
    static func getDataSource<T: Decodable>(from path: String, fileType: String, type: T.Type) -> T? {
        let path = Bundle.main.path(forResource: path, ofType: fileType)
        let url = URL(fileURLWithPath: path!)
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let model = try? JSONDecoder().decode(type.self, from: data) else { return nil }
        return model
    }

}
