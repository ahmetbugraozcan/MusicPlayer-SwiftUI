//
//  BaseError.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 23.12.2022.
//

import Foundation
struct BaseError : LocalizedError
{
    var errorDescription: String? { return mMsg }
    var failureReason: String? { return mMsg }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }

    private var mMsg : String

    init(_ description: String)
    {
        mMsg = description
    }
}
