//
//  GenericResource.swift
//  FX App
//
//  Created by Kuda Zata on 29/4/2023.
//

import Foundation

struct GenericResource<T> {
    let urlString: String
    let parse: (Data) -> T?
}
