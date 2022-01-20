//
//  MainViewController.swift
//  NetworkingApp
//
//  Created by Snow Lukin on 20.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var urlSessionButton: UIButton!
    @IBOutlet weak var alamofireButton: UIButton!
    
    // MARK: IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showPhotos", sender: sender)
    }
}

// MARK: - Navigation
extension MainViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let photosVC = segue.destination as? PhotosViewController else { return }
        switch sender as? UIButton {
        case urlSessionButton:
            photosVC.fetchPhotos()
        case alamofireButton:
            photosVC.fetchAlmofire()
        default:
            return
        }
    }
}
