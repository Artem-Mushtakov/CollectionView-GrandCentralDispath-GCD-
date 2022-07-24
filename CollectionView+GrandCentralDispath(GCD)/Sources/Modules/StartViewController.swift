//
//  StartViewController.swift
//  CollectionView+GrandCentralDispath(GCD)
//
//  Created by Artem Mushtakov on 24.07.2022.
//

import UIKit

protocol StartViewOutputProtocol: AnyObject {
    func succes()
}

class StartViewController: UIViewController {

    // MARK: - Properties

    var presenter: StartPresenter?

    // MARK: - Live cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension StartViewController: StartViewOutputProtocol {

    func succes() {
        print("Succes")
    }
}
