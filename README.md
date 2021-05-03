# AppleTree
Family Tree connection app
Original App Design Project - README Template
===

# AppleTree

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
A family tree app. The user can begin their tree with parents and children accounts. When the child grows up and leaves home they can stay connected to their parents and bring in their own family connections. Users can add stories, photos, and share location via real time mapping.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social media/ Lifestyle
- **Mobile:** This app will be mostly mobile but accessable via iMac.
- **Story:** Families can stay connected even after leaving home. Allows users to share experiences with other family members within the tree as well as new family connections. 
- **Market:** Any individual can use this app but are limited to their family connections. Only users of the same family can share and connect.
- **Habit:** The app allows families to check location of other family members however often they would like. And be able to post however often they choose.
- **Scope:** First allow users to connect with other family members. Allow users to invite new connections to the family. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Account creation
* Posting 
* Map location
* Expanding the tree

**Optional Nice-to-have Stories**

* Notifications/ alarms
* Family photo collage/ gallery
* Family household

### 2. Screen Archetypes

* Login
* Register- User signs up or logs in to their account
   * Upon Download/Reopening of the application, the user is prompted to log in to gain access to their profile information. If a user is signing up they can either join their existing family tree if previously or declare a new tree to begin.
* Family posting Feed
   * Users can post daily activities, pictures, quotes, videos/ links and events.
* Map location
   * User may request current family members location via real time. 
* Expanding the tree
   * User is prompeted to declare independency and given the option to share the family code.



### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Family posting feed
* Camera
* Map/ Location
* Account/ settings
    * User profile, link code, and logout

**Flow Navigation** (Screen to Screen)

* Forced Log-in -> Account creation if no log in is available
* Family Feed -> Family chat 
* Camera -> Gallery view with the first box as camera for new photos
* Map -> Shows world map with current family members with show location on
* Account/ settings -> Shows user profile, settings for fontsize, option to turn on or off location, family connection code, and logout buttton
   

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src= 20210318_114005.jpg width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
Posting
| Property     | Type             | Description                                      |
|--------------|------------------|--------------------------------------------------|
| userAccount  | pointer to user  | Current Username                                 |
| Author       | pointer to user  | Current user image                               |
| createdDate  | DateTime         | date when post is created(default field)         |
| createdTime  | DateTime         | Time when post is created(default field)         |
| messageField | string           | Chat for user typing                             |
| image        | File             | User can post file saved photos or take new ones |
| caption      | String           | Comment on user image                            |

User
| Property        | Type    | Description                     |
|-----------------|---------|---------------------------------|
| userName        | String  | Show username                   |
| accountPassword | String  | Holds account password          |
| isUserShow      | boolean | If user wants to show on map    |
| treeId          | String  | Group code for family tree      |
| userImage       | File    | User profile image/ placeholder |

Images
| Property      | Type   | Description                     |
|---------------|--------|---------------------------------|
| image         | File   | Image to be stored              |
| imageCategory | String | To identify the types of images |

Mapping
| Property   | Type                     | Description                         |
|------------|--------------------------|-------------------------------------|
| mappedUser | Pointer to User          | Shows location of app user on a map |
| placedPin  | GeoLocation              | Place notifications/ hotspots       |
| createdAt  | DateTime                 | Shows current time                  |

### Networking
- (Create/post) Create user account
  ```swift
   let user = PFUser()
   
   user.username = usernameField.text
   
   user.password = passwordField.text
   
   user["userImage"] = UIImage(named: "defaultUserImage")
   
   user.signUpInBackground{ (success, error) in
   if success {
       // Got to home feed
       } else {
          //print error
          }
  ```
- (Create/post) Sign-In
  ```swift
  let username = usernameField.text!
  let password = passwordField.text!
  
  PFUser.logInwithUsername(inBackground: username, passwoed: password) {
    (user, error) in
      if success {
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
        } else {
            print("Error: \(error?.localizedDescription)")
        }
      }
  }
  ```
-(Update/put) Show location on
  ```swift
  let locationManager = CLL ocationManager()
  
  func setupLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  func checkLocationServices() {
    if CLLocationManger.locationServicesEnabled() {
      setupLocationManager()
      checkLocationAuthorization()
    } else {
      // show alert letting the user know they have to turn this on.
    }
    
    func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
      case .authorizedWhenInUse:
        // Do Map stuff
         break
     case .denied:
        // show alert instructing them how to turn on permissions
        break
     case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
     case .restricted:
      // show an alert letting them know know whats up
      break
     case .authorizedAlways:
      break
     }
  } 
  ```
- (Create/post) Comment
  ```swift
      func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // Create the comment
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!  

        selectedPost.add(comment, forKey: "comments")
        

        selectedPost.saveInBackground { (success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error saving comment")
            }
        }
        tableView.reloadData()
        

        // Clear and dismiss the input bar
        commentBar.inputTextView.text = nil
        

        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
  ```
- (Update/put) Change user image
  ```swift
  @IBAction func onCameraButton(_ sender: Any){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }

  ```
  (Create/ post) posting to chat feed
  ~~~swift
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: indexPath) -> UITableViewCell {
    let post  = posts[indexPath.section]
      if indexPath.row == 0 {
    let cell = tableView.dequeueReusableCell(withIdentifier: "feedContent") as! PostCell
    let user = post["author"] as! PFUser
      cell.usernameLabel.text = user.username
    let imageFile = post["image"] as! PFFileObject
      return cell
  }
  ~~~
  
  (Read/ Get) Pull images
  ~~~swift
  @IBAction func onGallery(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        
        present(picker, animated: true, completion: nil)
    }
    ~~~
## Build Sprint 1
- [x] Create a parse import
- [x] Import parse file
- [x] Share Xcode file for pulling and pushing
- [x] Add labels
- [x] Text Field
- [x] Sign in button
- [x] Sign Up button
- [x] Link outlets
- [x] Create segue
- [x] Make navigation bar with 4 linked views
- [x] Window for map
- [x] Window for feed view
- [x] Window for image gallery
- [x] Window for settings

## Video Walkthrough Sprint 1

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/mevX97P2lD.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Build Sprint 2
Adding outlets and page design 
- [x] Create a view controller for map
- [x] Create a view controller for family chat
- [x] Create a view controller for images
- [x] Create a view controller for settings
- [x] Image for app icon
- [x] Loading screen image
- [x] Login background
- [x] Tab bar controller icons

## Video Walkthrough Sprint 2

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/QPeCEhzHla.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Build Sprint 3

- [x] Account stays logged in until logout - MIchael
- [x] Make pop-up keyboard removable when pushed down - Brayden
- [x] Code the settings to be able to change user image - Michael
- [x] Button to get user location - Jonzo
- [x] Geo code location - Jonzo
- [x] Option button for camera or stock photos - Brayden

## Video Walkthrough Sprint 3

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/6e6oHqOeke.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Build Sprint 4 Final

- [x] Sign up makes a new user
- [x] Sign in logs in the user if they have an account
- [x] Post to family feed and shows old posts
- [x] Navigation bar changes to the right window
- [x] Can switch between different views
- [x] Image gallery loads photos and camera can be used to take new image
- [x] Settings shows current user 
- [x] Can edit user picture
- [x] Log out button logs out user to sign in
- [x] Constraints 
- [x] User profile picture and comment user picture next to post/comment
- [x] Generated group code
- [x] Color Scheme
- [x] Text size button works

## Video Walkthrough Sprint 4 Final

<img src='http://g.recordit.co/2akJmpRONU.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
