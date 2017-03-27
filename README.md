# Travel-Bro
Read Me

1.	Open TravelBro.xcworkspace File 
2.	Note: This application is developed using the latest version of Swift, Xcode and El Capitan OS. So please run the app in the latest version else there might be build errors in the older version
3.	Clean the solution
 
4.	Build the solution
 
5.	Run the app
 
6.	Simulate the Location - This is important since we are using location services
 
7.	Click on Existing login
8.	UserName :  admin
9.	Password :   admin
 
10.	Search for the type of place you need to visit at the top menu. This is a dropdown menu
 

 
11.	Enter the radius/miles for the same. i.e  600
12.	Click on Search
 
13.	Click on any one pin.
 
14.	Click on the button once displayed with the pin.
15.	This redirects to the next page where we can hire a guide
 
16.	Click on Hire a guide button
17.	Click on hire option among the guides available
18.	Review for a particular can be added by the user.
 
19.	Hired success message will be displayed
 

Presentation Link: http://slides.com/manjunathb/deck-4/fullscreen



Travel Bro iOS App
Project Proposal
Darshan Masti Prakash. (SUID: 223909540)
Manjunath Babu. (SUID: 515114647)
Objective: Build an IOS Application that helps a user discover people
who like to travel together to new places and also hire a local travel
guide.
Application Name: Travel Bro
Brief Overview: When a person visits a new city, its very unclear initially to decide
which is good place to visit. If the person has come alone to a new city, it would
be really good to find a travel companion for a quick visit. At times, hiring local
guide would be the best option. Our IOS application incorporates the above
features to the user thus making travelling to new places even better.
Login: We use Facebook API to log in to the application and building the user
profile.
User Profile: Apart from the data that comes from the API, we also use GPS to
detect user’s current location. We intend to use SQLLite database to store all the
profiles.
App Model: Ask weather user wants to visit a new place or contribute
information to an existing place and selecting an option to become a local tour
guide.
Populate Places: Search results are narrowed down based on Category, Distance
and City. Ex: I want to Visit a New Place in Category Scenic Places within 10 miles
of Syracuse, NY. This custom search query is used to populate results from Google
Maps or TripAdvisor API.
Select a Place: Upon user selecting a place that he wishes to visit, a new screen
containing detailed information populates. An option to take a photo and upload
it. Mark as favorite place. Add to wish list. Etc. There is also an option to get a
Travel Guide in the end.
Travel Guide Screen: Once a user decides to get a local travel guide, based on
various parameters, a list is displayed along with the credits required to hire. This
screen also shows current available credits and a Buy option to purchase more.
Payment Modes: User will be given various modes of payment to choose from.
This feature will be incorporated via an API call.
Emergency Contact: If a user is confused in a new place and finds difficult to
explore, an emergency call feature can be used to reach the central office. We
plan on implementing a “Call Now” button phone service.
Mapping Service: This will be used in multiple places. 1) A map will be displayed
next to the new visit place photo. 2) A map will be displayed on the user guide
screen showing how far is he located.
Local Travel Guide Concept (Credits): Users who have very good knowledge on
specific places to visit will contribute their views to this app for credits. If a
traveler finds it helpful and up votes, Users gain credits. Contrarily, if there is
spam or irrelevant information, it results in a down vote thus making it hard to
gain credits.
Monetization: Since this app matches new visitors to existing experts, we charge
a fee to make this match based on the above credits thus benefiting both.
Database: We plan on maintaining the following databases. 1) User profiles. 2)
Reviews of the places written by the users. 3) Local Travel Guide list
Conclusion: Followed the guidelines as per requirements and provided tentative
screenshots of the prototype below.

