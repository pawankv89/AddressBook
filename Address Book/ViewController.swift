//
//  ViewController.swift
//  Address Book
//
//  Created by Pawan kumar on 06/01/20.
//  Copyright © 2020 Pawan Kumar. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var contactStore = CNContactStore()
    var contacts = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let keysToFetch = [
        CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
        CNContactEmailAddressesKey,
        CNContactPhoneNumbersKey,
        CNContactImageDataAvailableKey,
        CNContactThumbnailImageDataKey] as! [CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)

        do {
            try self.contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                self.contacts.append(contact)
            }
        }
        catch {
            print("unable to fetch contacts")
        }

        print("contacts:- \(contacts)")
        
        //Refresh List
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
             
        self.tableView.estimatedRowHeight = 80 //Use less when recived data No 0 otherwise not set cell size default
        self.tableView.rowHeight = UITableView.automaticDimension

    }

}

extension ViewController {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
       {
        if self.contacts.count > 0 && self.contacts.count > section
           {
               return self.contacts.count
           }
           return 0
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier: String = "LabelCell"
        var cell: LabelCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? LabelCell
        if (cell == nil)
        {
            let nib: Array = Bundle.main.loadNibNamed("LabelCell", owner: self, options: nil)!
            cell = nib[0] as? LabelCell
        }
    
     //Cell Selection
     //cell?.selectionStyle = .none
     
     // Set the selected cell's background to a light mint green color
     let bgColorView = UIView()
     bgColorView.backgroundColor = UIColor.cyan
     cell!.selectedBackgroundView = bgColorView
        
    let contact = self.contacts[indexPath.row]
    let formatter = CNContactFormatter()
                
    cell!.nameLabel.text = formatter.string(from: contact)
    cell!.contactLabel.text = getAllPhones(contact: contact)
    cell!.emailLabel.text = getAllEmailAddresses(contact: contact)
    
     return cell!
    }
    
    func getAllEmailAddresses(contact: CNContact) -> String {
        var emails = ""
        var emailAddresses: Array <String> = []
        for email in contact.emailAddresses {
            emailAddresses.append(email.value as String)
        }
        emails = emailAddresses.joined(separator: ", ")
        return emails
    }
    func getAllPhones(contact: CNContact) -> String {
        var phones = ""
        var phoneNumbers: Array <String> = []
        for ContctNumVar: CNLabeledValue in contact.phoneNumbers {
            if let fulMobNumVar  = ContctNumVar.value as? CNPhoneNumber {
                //let countryCode = fulMobNumVar.value(forKey: "countryCode") get country code
                   if let MccNamVar = fulMobNumVar.value(forKey: "digits") as? String {
                        phoneNumbers.append(MccNamVar)
                }
            }
        }
        
        phones = phoneNumbers.joined(separator: ", ")
        return phones
    }
}

