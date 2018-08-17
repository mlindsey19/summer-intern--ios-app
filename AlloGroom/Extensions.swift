//
//  Extensions.swift
//  AlloGroom
//
//  Created by mitch on 8/17/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit
import Contacts
import Alamofire



extension UIImage {
    func scaleDownImage(toSize newSize:CGSize) -> UIImage? {
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        context.interpolationQuality = .high
        let flipVerticle = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
        context.concatenate(flipVerticle)
        context.draw(self.cgImage!, in: newRect)
        let newImage = UIImage(cgImage: context.makeImage()!)
        UIGraphicsEndImageContext()
        return newImage
    }
}
extension UIViewController {
    func convertImageToBase64(image: UIImage) -> String {
        
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData?.base64EncodedString(options: [])
        
        return base64String!
        
    }
    //TODO: change from NSdata??????
    func convertBase64ToImage(base64String: String?) -> UIImage {
        
        
        guard  let decodedData = Data(base64Encoded: base64String!, options: .ignoreUnknownCharacters), let image = UIImage(data: decodedData), (base64String?.isEmpty)! else {
            return #imageLiteral(resourceName: "defaultProfileImage")
        }
        
        return image
        
    }
}

extension EmailListTableViewController {
    
    func fetchContacts(withCompletion completion: @escaping () -> Void) {
        print("attempting to fectch contacts..")
        
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("failed to rewuest access: ", err)
                return
            }
            
            if granted {
                print("access granted")
                //                keys to access contacts for request
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey]
                
                //                request with access keys
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    //                    enumerate threww contacts
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        
                        print(contact.givenName)
                        print(contact.emailAddresses.first?.value ?? "")
                        
                        //                        append contacts to array if they have an email
                        if (!contact.emailAddresses.isEmpty) {
                            
                            self.contactsArray.append(ContactStruct(firstName: contact.givenName, lastName: contact.familyName, email: (contact.emailAddresses.first?.value ?? "")!))
                        }
                        
                    })
                    
                } catch let err {
                    print( "failed to enumerate contacts: ", err)
                }
                
            }else {
                print("access denied...")
                
            }
            
            completion()
        }
        return
    }
    
}

extension RatingTableViewController {
    
    func fetchTraits(withCompletion completion: @escaping () -> Void) {
    
        let traitNumber: Int = 1
        
        let parameters: Parameters = [
            "traitNumber":traitNumber
        ]
        
        Alamofire.request(URL.getTraits, method: .post, parameters: parameters).responseJSON { response in
            print(response.result)  // result of response serializaion
            
            guard let data = response.data else {print("data var not initilized correctly"); return}
            let decoder = JSONDecoder()
            guard (try? decoder.decode(JSONResponseStruct.self, from: data)) != nil
                else {print("did not parse correctly")
                    return
            }
            //
            
            
        }
        completion()

    }
}
