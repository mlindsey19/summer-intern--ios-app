//
//  EmailFromContactsTableViewController.swift
//  AlloGroom
//
//  Created by Daniel Reller on 8/15/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit
import Contacts

class EmailFromContactsTableViewController: UITableViewController {

   
    //MARK: Properties

    
      let cellIdentifier = "emailTableViewCell"

    var contactsArray:[ContactStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       fetchContacts()

        tableView.register(contactTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.contactsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? contactTableViewCell else {
            fatalError( "the dequed cell was not an instance of contactTableviewCell")
        }
        
        let contactWithEmail = contactsArray[indexPath.row]
        let lastname = contactWithEmail.lastName ?? ""
        cell.nameLabel?.text = "\(contactWithEmail.firstName) \(lastname)"
        cell.emailLabel?.text = "\(contactWithEmail.email)"
        
    return cell
    }
    
    

private func fetchContacts() {
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

