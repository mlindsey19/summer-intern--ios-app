//
//  EditProfileTableViewController.swift
//  vici_mitch
//
//  Created by Mitch on 6/23/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit
import Alamofire

class EditProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    
    //MARK: properties
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var userBioTextView: UITextView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //background
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImage"))
        
        firstNameTextField.text = CurrentUser.firstName!
        lastNameTextField.text = CurrentUser.lastName!
        usernameTextField.text = CurrentUser.desiredUsername!
        userBioTextView.text = CurrentUser.userBio!
        mobileNumberTextField.text = CurrentUser.mobileNumber!
        emailTextField.text = CurrentUser.email!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    //Actions:
    
    @IBAction func editProfilePicture(_ sender: UIButton) {
        // Hide the keyboard.
        
        for textField in self.textFields{
            textField.resignFirstResponder()
        }
        userBioTextView.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        //TODO: add choice for camera or photoLibrary
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    
    
    

    @IBAction func updateProfileSaveButton(_ sender: Any) {
        
        //convert immage to string
        let size = CGSize(width: 50, height: 50)
        let scaledDownImage = userProfileImage.image?.scaleDownImage(toSize: size)
        let imageString = convertImageToBase64(image: scaledDownImage!)
        
        
        
        
        
        guard   let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty,
            let userName = usernameTextField.text, !userName.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let userBio = userBioTextView.text, !userBio.isEmpty,
            let mobileNumber = mobileNumberTextField.text, !mobileNumber.isEmpty
        
        
            else {
                //TODO: handle error
                return
        }
        
        let parameters: Parameters = [
            Keys.firstName:firstName,
            Keys.lastName:lastName,
            Keys.desiredUserName:userName,
            Keys.email:email,
            Keys.mobileNumber:mobileNumber,
         //   Keys.password:password,
            Keys.userBio:userBio,
            Keys.photoStorage:imageString,
            Keys.uniqueID:CurrentUser.uniqueID!
        ]
        
        
    //POST request
        Alamofire.request(URL.updateUser, method: .post, parameters: parameters).responseJSON { response in
            print(response.result)  // result of response serializaion
            guard let data = response.data else {print("data var not initilized correctly"); return}
            let decoder = JSONDecoder()
            guard let userInfo = try? decoder.decode(JSONResponseStruct.self, from: data)
                else {print("did not parse correctly")
                    return
            }
            
            // assign user info to static var
            CurrentUser.firstName = userInfo.firstName!
            CurrentUser.lastName = userInfo.lastName!
            CurrentUser.desiredUsername = userInfo.desiredUsername!
            CurrentUser.mobileNumber = userInfo.mobileNumber!
            CurrentUser.email = userInfo.email!
            CurrentUser.photoStorage = userInfo.photoStorage!
            CurrentUser.userBio = userInfo.userBio!
            CurrentUser.error = userInfo.error!
            CurrentUser.message = userInfo.message!
            
            
            // redirected to homescreene if register succesfully
            
            let updateSuccess = "Update Successful"
            if userInfo.message == updateSuccess {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "homeView")
                self.present(viewController, animated: true, completion: nil)
            }
            else {
                //TODO: handle register error
            }
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        userProfileImage.image = selectedImage
        
        userProfileImage.layer.cornerRadius = userProfileImage.frame.size.width / 2;
        
        userProfileImage.clipsToBounds = true
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }}
