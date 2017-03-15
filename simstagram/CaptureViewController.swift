//
//  CaptureViewController.swift
//  simstagram
//
//  Created by Simrandeep Singh on 3/14/17.
//  Copyright © 2017 Sim Singh. All rights reserved.
//

import UIKit
import Parse
import UITextView_Placeholder
import QuartzCore

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var taptoselectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionTextView.placeholder = "Write a caption..."
        captionTextView.placeholderColor = UIColor.lightGray

        captionTextView.layer.borderWidth = 2
        captionTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        mainImageView.image = originalImage
        
        taptoselectLabel.isHidden = true
        
        let size = CGSize(width: 250, height: 250)
        mainImageView.image = resize(image: originalImage, newSize: size)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    @IBAction func onSelectImage(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onShare(_ sender: Any) {
        Post.postUserImage(image: mainImageView.image, withCaption: captionTextView.text) { (success: Bool, error: Error?) in
            if (success) {
                self.tabBarController?.selectedIndex = 0
                self.captionTextView.text = ""
                self.taptoselectLabel.isHidden = false
                self.mainImageView.image = #imageLiteral(resourceName: "iconmonstr-picture-8-240")
            } else {
                print(error?.localizedDescription ?? "There was an error")
            }
        }
    }
    
    @IBAction func onCancel(_ sender: Any) {
        taptoselectLabel.isHidden = false
        captionTextView.text = ""
        mainImageView.image = #imageLiteral(resourceName: "iconmonstr-picture-8-240")
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
