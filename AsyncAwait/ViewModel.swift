//
//  ViewModel.swift
//  AsyncAwait
//
//  Created by Danny Tsang on 11/30/22.
//

import UIKit

protocol ViewModelDelegate: AnyObject {
    func refreshView()
}

class ViewModel {

    weak var delegate: ViewModelDelegate?

    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.refreshView()
            }
        }
    }

    var image: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.refreshView()
            }
        }
    }

    init(delegate: ViewModelDelegate? = nil, isLoading: Bool  = false, image: UIImage? = nil) {
        self.delegate = delegate
        self.isLoading = isLoading
        self.image = image

        refreshData()
    }

    // Async Function
    private func downloadAsync() async -> UIImage? {
        isLoading = true
        try? await Task.sleep(nanoseconds: UInt64.random(in: 1...5) * 1_000_000_000)

        let images = ["xbox.logo", "playstation.logo", "apple.logo", "shazam.logo.fill", "trash.fill"]
        let randomImage = images.randomElement()
        let image = UIImage(systemName: randomImage ?? "")

        isLoading = false
        return image
    }

    func refreshData() {
        Task {
            image = await downloadAsync()
        }
    }
}
