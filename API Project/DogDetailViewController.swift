//
//  DogDetailViewController.swift
//  API Project
//
//  Created by Tyler May on 11/9/23.
//

import UIKit

class DogDetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var newImageButton: UIButton!
    
    var dogImageURL: String?
    let dogController = DogController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateImageView()
    }
    
    func updateImageView() {
        DispatchQueue.global(qos: .userInitiated) .async{
            if let imageURLString = self.dogImageURL, let imageURL = URL(string: imageURLString) {
                if let imageData = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    @IBAction func newImage(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            self.newImageButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.newImageButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        Task { @MainActor in
            do {
                let randomDogImageURL = try await dogController.fetchDog()
                dogImageURL = randomDogImageURL
                updateImageView()
            } catch {
                let alertController = UIAlertController(title: "Error", message: "Failed to fetch a new dog image.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}
