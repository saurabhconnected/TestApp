//
//  LoginViewModel.swift
//  TestApp
//
//  Created by Saurabh Shukla on 22/08/22.
//

import Foundation

protocol LoginViewModelProtocal {
    var countryList: [Country] { get }
    var selectedCountry: Country? { get set }
    func userExists(username: String, password: String) -> Bool
}

class LoginViewModel: LoginViewModelProtocal {
      var selectedCountry: Country?
    lazy var countryList: [Country] = {
        return fetchCountryList()
    }()
  
    
    func userExists(username: String, password: String) -> Bool {
        CoreDataManager.fetchUser(username: username, password: password) != nil
    }
    
    private func fetchCountryList() -> [Country] {
        if let countries = decodeJson(fromFile: "countries", to: [Country].self) {
            return countries
        }
        return []
    }
}
