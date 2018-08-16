//
//  AppDelegate.swift
//  vici_mitch
//
//  Created by Mitch on 6/7/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit
import Contacts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

   
    
    
    
    
    ///// buch a BS
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
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
    
  func fetchContacts() {
        print("attempting to fectch contacts..")
        
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("failed to rewuest access: ", err)
                return
            }
            
            if granted {
                print("access granted")
                
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        
                        print(contact.givenName)
                        print(contact.emailAddresses.first?.value ?? "")
                        
                        self.contactsArray.append(ContactStruct(firstName: contact.givenName, lastName: contact.familyName, email: (contact.emailAddresses.first?.value)!))
                        
                        
                    })
                    
                } catch let err {
                    print( "failed to enumerate contacts: ", err)
                }
                
            }else {
                print("access denied...")
                
            }
        }
        return
    }
    
}
