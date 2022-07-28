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

    // MARK: - Properties

    weak var view: StartViewOutputProtocol?
    private var rickAndMortyModel: RickandmortyModel?
    var sectionModel: [String: [Result]] = ["FemaleSection": [],
                                             "MaleSection": [],
                                             "UnknownSection": []]

    // MARK: - Initial

    required init(view: StartViewOutputProtocol) {
        self.view = view
        getDataCharacter()
    }

    // MARK: - Private func

    private func getDataCharacter() {
        let urlSession = URLSession.shared
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        let urlRequest = URLRequest(url: url)

        urlSession.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data else { return }

            if let rickandmortyModel = try? JSONDecoder().decode(RickandmortyModel.self, from: data) {
                self?.rickAndMortyModel = rickandmortyModel
                self?.getSectionModel()
                self?.view?.succes()
            } else {
                print("Ошибка парсинга JSON")
            }

            if let error = error {
                print("Ошибка запроса \(error.localizedDescription)")
            }
        }.resume()
    }

    private func getSectionModel() {
        guard let model = rickAndMortyModel?.results else { return }

        model.forEach { item in
            switch item.gender {
            case .female:
                sectionModel["FemaleSection"]?.append(item)
            case .male:
                sectionModel["MaleSection"]?.append(item)
            case .unknown:
                sectionModel["UnknownSection"]?.append(item)
            default:
                break
            }
        }
    }
}
