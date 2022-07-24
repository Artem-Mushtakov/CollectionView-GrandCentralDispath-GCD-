//
//  StartPresenter.swift
//  CollectionView+GrandCentralDispath(GCD)
//
//  Created by Artem Mushtakov on 24.07.2022.
//

import UIKit

protocol StartViewInputProtocol: AnyObject {

}

class StartPresenter: StartViewInputProtocol {

    weak var view: StartViewOutputProtocol?
    private var rickandmortyModel: RickandmortyModel?

    required init(view: StartViewOutputProtocol) {
        self.view = view
        getDataCharacter()
    }

    private func getDataCharacter() {
        let urlSession = URLSession.shared
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        let urlRequest = URLRequest(url: url)

        urlSession.dataTask(with: urlRequest) { data, _, error in
            guard let data = data else { return }

            if let rickandmortyModel = try? JSONDecoder().decode(RickandmortyModel.self, from: data) {
                self.rickandmortyModel = rickandmortyModel
            } else {
                print("Error parse JSON")
            }

            if let error = error {
                print("Ошибка запроса \(error.localizedDescription)")
            }
        }.resume()
    }
}
