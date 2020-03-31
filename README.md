# Test_Viaplay
# UI Look and Flow
- UI is basic, but under the hood it’s sturdy and can be easily customisable (colours, fonts…). 
- There are 3 screens, the start screen, the sections screen as a collection view, and the selected section screen as a table view
- When you first run the app, you have start streaming button, if there is no internet, you can tap it but you will get the warning. Here we DO NOT have offline support YET since I didn’t want the data to magically appear in the app
- If there is Internet, you can tap “start streaming” and go to the list of sections which is a collection view. There you have the header with title and description and n cells (in our case six) representing all the sections.
- When you tap a section cell, a table view opens with the info corresponding to the tapped section. For Film it’s film list, for Serrier its Series list and so on…
- There is a block screen with message, while loading the sections list and you can always go back and break the connection if you do not want to wait, it the same when tapping the sections item. You can play with this go back and forth etc. 
- For the case of first screen, I intentionally made a time out of 6 seconds. So, when you tap “start streaming” and go to the next section and back and try again, if the 6 s period has not passed, you will get the last successful downloaded data. This was made in order not to spam the server all the time with network requests
- In offline mode, you can open sections collection view and then the sections you ALREADY OPENED before ONLY. If you haven’t opened them before, you will get an alert that there is no internet. Again, I didn’t want the data to magically appear here, but only AFTER the first download, offline mode is possible everywhere. You can play with this, turn the net on and off, etc.

# Architecture
- Apple design guidelines were used
- MVVM was used as the architecture pattern 
- Unit test examples have been written for View Models
- Helper classes have been used to perform non View Controller logic
- Dependancy injection has been used and caching of data avoided
- Components for UI have been made, like Blocking Screen for example
- View Models are Initialised by models (thus the unit test are possible) 
- Networking library has been made as a separate networking layer with web services, decodable protocols, etc. It’s made to be very robust and I use this approach in all of my objects. The only foreign code here is related to the Rateability for the internet
- File structure is organised in the project to have folders like Components, Libs (Helpers, Networking), Resources, Sections, Models, ViewModels…
- For UI storyboards were used only for elements setup and auto-layout, but all else was done programatically, I personally would prefer all to be programatic if I had more time. 

# Instruction
- Download the app, start the project and input your bundle ID if you want to run on a real device and that is it, there are no dependencies of any kind. 
