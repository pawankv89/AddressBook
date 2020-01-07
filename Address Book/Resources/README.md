#  Refreces

## Links

https://stackoverflow.com/questions/33973574/fetching-all-contacts-in-ios-swift

https://www.appsfoundation.com/post/create-edit-contacts-with-ios-9-contacts-ui-framework

https://dev.to/kevinmaarek/add-a-scene-delegate-to-your-current-project-5on

https://www.ios-blog.com/tutorials/swift/contacts-framework-p1/

https://code.tutsplus.com/tutorials/ios-9-an-introduction-to-the-contacts-framework--cms-25599

https://www.raywenderlich.com/2547730-contacts-framework-tutorial-for-ios

https://www.appcoda.com/ios-contacts-framework/

https://stackoverflow.com/questions/32669612/how-to-fetch-all-contacts-record-in-ios-9-using-contacts-framework/36863671


var contacts: [CNContact] = {
    let contactStore = CNContactStore()
    let keysToFetch = [
        CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
        CNContactEmailAddressesKey,
        CNContactPhoneNumbersKey,
        CNContactImageDataAvailableKey,
        CNContactThumbnailImageDataKey] as [Any]

    // Get all the containers
    var allContainers: [CNContainer] = []
    do {
        allContainers = try contactStore.containers(matching: nil)
    } catch {
        print("Error fetching containers")
    }

    var results: [CNContact] = []

    // Iterate all containers and append their contacts to our results array
    for container in allContainers {
        let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)

        do {
            let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
            //results.append(containerResults)
        } catch {
            print("Error fetching results for container")
        }
    }

    return results
}()

print("contacts:- \(contacts)")



self.contactStore.requestAccess(for: CNEntityType.contacts){succeeded, err in
       guard err == nil && succeeded else{
        return
     }
    
   print("self.contactStore:- \(self.contactStore)")
    self.retrieveContactsWithStore(store: self.contactStore)
}

    
    
    func retrieveContactsWithStore(store: CNContactStore) {
        do {
            let groups = try store.groups(matching: nil)
            
            //let predicate = CNContact.predicateForContacts(matchingEmailAddress: friend.workEmail)
            let predicate = CNContact.predicateForContactsInGroup(withIdentifier: groups[0].identifier)
            //let predicate = CNContact.predicateForContactsMatchingName("John")
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactEmailAddressesKey] as [Any]
             
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
            
            
             print("contacts:- \(contacts)")
            
        } catch {
            print(error)
        }
    }

    
    
    func requestForAccess(completionHandler: (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
     
        switch authorizationStatus {
        case .authorized:
            completionHandler(true)
            
        case .denied, .notDetermined:
           self.contactStore.requestAccess(for: CNEntityType.contacts){succeeded, err in
                   guard err == nil && succeeded else{
                    return
                 }
            }
     
        default:
            completionHandler(false)
        }
    }
    
    
    /*
    func getContacts() {
        let store = CNContactStore()
         
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
            store.requestAccess(for: .contacts, completionHandler: { (authorized: Bool, error: NSError?) -> Void in
                if authorized {
                    //self.retrieveContactsWithStore(store: store)
                }
                } as! (Bool, Error?) -> Void)
        } else if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            //self.retrieveContactsWithStore(store: store)
        }
    }
    */
    
    /*
    func retrieveContactsWithStore(store: CNContactStore) {
        do {
            let groups = try store.groups(matching: nil)
            let predicate = CNContact.predicateForContactsInGroup(withIdentifier: groups[0].identifier)
            //let predicate = CNContact.predicateForContactsMatchingName("John")
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactEmailAddressesKey] as [Any]
             
            let contacts = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
            self.objects = contacts
           
            DispatchQueue.main.sync {
                 self.tableView.reloadData()
            }
            
        } catch {
            print(error)
        }
    }*/
