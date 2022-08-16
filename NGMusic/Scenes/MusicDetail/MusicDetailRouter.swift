//
//  MusicDetailRouter.swift
//  NGMusic
//
//  Created by Deepak on 05/08/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol MusicDetailRoutingLogic {

}

protocol MusicDetailDataPassing {
  var dataStore: MusicDetailDataStore? { get }
}

class MusicDetailRouter: NSObject, MusicDetailRoutingLogic, MusicDetailDataPassing {
  weak var viewController: MusicDetailViewController?
  var dataStore: MusicDetailDataStore?

}
