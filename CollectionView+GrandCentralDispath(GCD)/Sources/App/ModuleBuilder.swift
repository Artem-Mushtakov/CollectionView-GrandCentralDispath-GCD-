//
//  ModuleBuilder.swift
//  CollectionView+GrandCentralDispath(GCD)
//
//  Created by Artem Mushtakov on 24.07.2022.
//

import UIKit

protocol Builder {
    static func createStartModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createStartModule() -> UIViewController {
        let startViewController = StartViewController()
        let startView = StartView()
        let startPresenter = StartPresenter(view: startViewController)
        startViewController.view = startView
        startViewController.presenter = startPresenter
        return startViewController
    }
}
