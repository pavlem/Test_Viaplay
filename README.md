# Test_Viaplay
# UI Look 
- The focus was not on UI, but structurally it was made to be sturdy and stable. Storyboards were used for encapsulating UI components, but most of the things were made programatically like Blocking Screen component, setting the UI in view controllers and cells and etc....


- First screen is the Start screen (application entry) and there the user has to input the city name which cannot have less than 3 characters
- If you turn off the internet on this first screen you will also receive an alert indicating that there is no Internet and you will not be able to proceed 
- After entering the city, blocking screen appears while data is being download from the net. Received data is filtered by days and the result is shown in the table view. Each row is one day which in turns holds per hour info
- When tapping the day, a new table view appears with the 3 hour periods. Note that the same Table View component was reused intentionally  
- When tapping the 3 hour period, detail screen is shown for selected time-frame where the detail screen is a very simple component (one UITextView) and data is dumped there in string form
- On 5 days Table view you also have switch in navigation bar to choose between the API and local JSON. 
- For both cases, icons are downloaded and Cached to save on networking 

# Architecture
- Apple design guidelines were used
- MVVM was used as the architecture pattern 
- Unit test example has been written
- Helper classes have been used to perform non View Controller logic
- Dependancy injection has been used and caching of data avoided
- Components for UI have been made, like Blocking Screen for example
- View Models are Initialised by models (thus the unit test are possible) 
- Networking library has been made as a separate networking layer with web services, decodable protocols, etc. It’s made to be very robust and I use this approach in all of my objects
- File structure is organised in the project to have folders like Components, Libs (Helpers, Networking), Resources, Sections, Models, ViewModels…

# Instruction
- Download the app, start the project and input your bundle ID, that is it, there are no dependencies 
