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
Posting/ Chat View
| Property     | Type     | Description                                      |
|--------------|----------|--------------------------------------------------|
| Author       | User     | image author                                     |
| createdDate  | DateTime | date when post is created(default field)         |
| createdTime  | DateTime | Time when post is created                        |
| messageField | string   | Chat for user typing                             |
| image        | File     | User can post file saved photos or take new ones |
| caption      | String   | Comment on user image                            |



### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

Schema
Models
Post
Property	Type	Description
objectId	String	unique id for the user post (default field)
author	Pointer to User	image author
image	File	image that user posts
caption	String	image caption by author
commentsCount	Number	number of comments that has been posted to an image
likesCount	Number	number of likes for the post
createdAt	DateTime	date when post is created (default field)
updatedAt	DateTime	date when post is last updated (default field)
Networking
List of network requests by screen
Home Feed Screen
(Read/GET) Query all posts where user is author
let query = PFQuery(className:"Post")
query.whereKey("author", equalTo: currentUser)
query.order(byDescending: "createdAt")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(posts.count) posts.")
  // TODO: Do something with posts...
   }
}
(Create/POST) Create a new like on a post
(Delete) Delete existing like
(Create/POST) Create a new comment on a post
(Delete) Delete existing comment
Create Post Screen
(Create/POST) Create a new post object
Profile Screen
(Read/GET) Query logged in user object
(Update/PUT) Update user profile image
[OPTIONAL:] Existing API Endpoints
An API Of Ice And Fire
Base URL - http://www.anapioficeandfire.com/api

HTTP Verb	Endpoint	Description
GET	/characters	get all characters
GET	/characters/?name=name	return specific character by name
GET	/houses	get all houses
GET	/houses/?name=name	return specific house by name
Game of Thrones API
Base URL - https://api.got.show/api

HTTP Verb	Endpoint	Description
GET	/cities	gets all cities
GET	/cities/byId/:id	gets specific city by :id
GET	/continents	gets all continents
GET	/continents/byId/:id	gets specific continent by :id
GET	/regions	gets all regions
GET	/regions/byId/:id	gets specific region by :id
GET	/characters/paths/:name	gets a character's path with a given name
