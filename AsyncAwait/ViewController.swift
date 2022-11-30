//
//  ViewController.swift
//  AsyncAwait
//
//  Created by Danny Tsang on 11/30/22.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = ViewModel()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.blue.cgColor
        imageView.layer.borderWidth = 2.0
        imageView.layer.cornerRadius = 10.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let refreshButton: UIButton = {
        var attributeContainer = AttributeContainer()
        attributeContainer.font = UIFont.boldSystemFont(ofSize: 16.0)

        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString("Refresh", attributes: attributeContainer)
        config.image = UIImage(systemName: "refresh")
        config.imagePlacement = .trailing
        config.imagePadding = 20

        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupButtons()
        layoutView()
        updateView()
    }

    func setupView() {
        view.backgroundColor = UIColor.white

        viewModel.delegate = self
    }

    func setupButtons() {
        refreshButton.addTarget(self, action: #selector(refreshImage), for: .touchUpInside)
    }

    func layoutView() {
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(refreshButton)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -50),

            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),

            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
        ])
    }

    func updateView() {
        print("Updating View...")

        titleLabel.text = viewModel.isLoading ? "Loading Image..." : "Image Loaded"
        imageView.image = viewModel.image
        refreshButton.configuration?.showsActivityIndicator = viewModel.isLoading
    }

    // Async Call
    @objc func refreshImage() {
        viewModel.refreshData()
    }
}

extension ViewController: ViewModelDelegate {
    func refreshView() {
        updateView()
    }
}
