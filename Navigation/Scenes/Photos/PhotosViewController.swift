//
//  PhotosViewController.swift
//  Navigation
//
//  Created by 1234 on 07.04.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    var imagePublisherFacade = ImagePublisherFacade()
    private var imagesDelayArray = [UIImage]()
    private let imageSourceArray = Photo.makeArrayImages()
    private var imagesFilterArray = [CGImage?]()


    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Gallery"
        view.backgroundColor = .white
        layout()
        // Загрука изображений в массив изображений 'imagesDelayArray' с задержкой
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 1, repeat: 20, userImages: Photo.makeArrayImages())
        // Проверка влияний приоритета потока при обработке изображений IOSINT HW-8
        let qos: QualityOfService = .default
        let startTime = Date()
        ImageProcessor().processImagesOnThread(sourceImages: Photo.makeArrayImages(), filter: .colorInvert, qos: qos) {
            self.imagesFilterArray = $0
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            print("Изображения были обработаны в течение \(Date().timeIntervalSince(startTime)) секунд")
        }

    }

    override func viewDidDisappear(_ animated: Bool) {
        imagePublisherFacade.removeSubscription(for: self)
    }



    private func layout() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([

            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesFilterArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
//        cell.setupCell(photo: imagesDelayArray[indexPath.row])
        var image = UIImage()
        let notAvailableImage = UIImage(systemName: "exclamationmark.icloud.fill")!
        if let cgImage =  imagesFilterArray[indexPath.row] {
            image =  UIImage(cgImage: cgImage)
        } else {
            image = notAvailableImage
        }
//        image = imageSourceArray[indexPath.row]
        cell.setupCell(photo: image)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 4 * sideInset) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
}

//MARK: - ImageLibrarySubscriber

extension PhotosViewController: ImageLibrarySubscriber {

    func receive(images: [UIImage]) {
        imagesDelayArray = images
        collectionView.reloadData()
    }

}
