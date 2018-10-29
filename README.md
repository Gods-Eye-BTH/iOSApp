# iOSApp
## Introduction
This is an app made for the iPhone, where the user inputs a video streaming URL in the HLS format along with a URL to a server parsing the JSON data. Since the project is lacking a real server at the moment, the functionality has not been implemented to support connecting to a real server for the JSON data. So in the current state, simply leave the JSON textfield empty to use  the localhost. The project can be used with a JSON dummy server to parse sample data. 

The dummy server can be launched by navigating into the JsonServer folder in the terminal and executing this command: `json-server --watch db.json`. To install the Json dummy server, simply execute the command `npm install -g json-server` in the terminal. 

## Launch Screen
At launch time the user is greeted by a screen with two textfields. One for the video feed, one for the JSON server.
You can either type in a new video url in the upper text field, in which case the app will add that connection to your list of recent connections. Or you can choose a recent connection from the list. In both cases, press connect when you’re ready. 
At the moment, leave the json textfield empty to use localhost. 


## Video Screen
When the user clicks connect, he's taken to the next viewcontroller. Here he's greeted by the video fetched from the server, as well as a table view where all the JSON objects parsed from the server are displayed. To add objects to the table view, add objects to the "db.json" file in the JsonServer folder. The json objects uses this common format (same as for the Android app)

```
{
  "Robots": [
    {
      "id": 1,
      "name": "Impact",
      "x": 177,
      "y": 200,
      "width": 10,
      "heigth": 10
    },
    {
        "id": 2,
        "name": "Space Conquerer",
        "x": 388,
        "y": 200,
        "width": 10,
        "heigth": 10
    },
    {
        "id": 3,
        "name": "Horror",
        "x": 300,
        "y": 50,
        "width": 10,
        "heigth": 10
    }
  ]
}
```
After connecting the user will be greeted by the screen on the right
![ConnectionScreen](https://github.com/Gods-Eye-BTH/iOSApp/blob/master/Ska%CC%88rmavbild%202018-10-29%20kl.%2011.01.26.png "Connection Screen")
![VideoScreen](https://github.com/Gods-Eye-BTH/iOSApp/blob/master/Ska%CC%88rmavbild%202018-10-29%20kl.%2010.54.35.png "Video Screen")
At the moment, no actual robots will be seen. There's only a dummy video being played. However, when the video server is completely setup with a working HLS url it can be displayed by putting it into the video url textfield on the previous page. 
Under the video, you can see all the robots parsed from the JSON object. At the moment, these can only be displayed using the simulator since the app uses the localhost connection created by the JSON dummy server. 

Each robot can be selected by pressing its ID number. When selected, you can change its X and Y-coordinates by using the arrows beside the play button. This doesnt actually change the json file, but it's meant to create a movement-object which can at a later stage be sent to the navigation server to actually move the objects. 

### Update frequency
At the moment, the update frequency is 5 seconds for the JSON objects. If you change the json.db file, the content in the table view will be automatically updated. The frequency of the updates are hardcoded in the project, but can easily be changed by going into the VideoViewController and finding the line where `jsonTimer` is initialized. On the line, simply change the timeInterval argument in the function call to `jsonTimer = Timer.scheduledTimer(timeInterval: secondsPlaceholder, target: self, selector: #selector(updateJson), userInfo: nil, repeats: true)`

## Running App on iPhone
1. Plug in iPhone using USB-cable. 
2. In Xcode, navigate into  Preferences -> Accounts, and add your apple ID. 
3. On your iPhone, you should see a popup asking you to trust the device. Click on accept. 
4. Where you usually select which simulator you want to use, you should now be able to select "Name's iPhone" at the top of the list. Select it and press CMD+R to run the app. 
Make sure you always run the app using CMD+R, don't run it by clicking on the icon on the springboard, since this will not compile the last changes in your code. 
