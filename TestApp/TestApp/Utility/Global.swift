//
//  Global.swift
//  TestApp
//
//  Created by Saurabh Shukla on 22/08/22.
//

import Foundation
import UIKit

func decodeJson<T: Decodable>(fromFile fileName: String, to: T.Type) -> T? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

let safeArea: UIEdgeInsets = {
    let window = UIApplication.shared.keyWindow
    return window?.safeAreaInsets ?? UIEdgeInsets.zero
}()
