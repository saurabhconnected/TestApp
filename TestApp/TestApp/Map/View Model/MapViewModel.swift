//
//  MapViewModel.swift
//  TestApp
//
//  Created by Saurabh Shukla on 23/08/22.
//

import Foundation
protocol MapViewModelProtocal {
    var address: Address! { get set }
}

class MapViewModel: MapViewModelProtocal {
    var address: Address!
}
