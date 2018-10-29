# iOSApp
## Introduction
This is a app made for the iPhone, where the user inputs a video streaming URL in the HLS format along with a URL to a server parsing the JSON data. Since the project is lacking a real server at the moment, the functionality has not been implemented to support connecting to a real server for the JSON data. So in the current state, simply leave the JSON textfield empty to use  the localhost. The project can be used with a JSON dummy server to parse sample data. 

The dummy server can be launched by navigating into the JsonServer folder in the terminal and executing this command: "json-server --watch db.json". To install the Json dummy server, simply execute the command "npm install -g json-server" in the terminal. 

## Launch Screen
At launch time the user is greated by a screen with two textfields. One for the video feed, one for the JSON server.
You can either type in a new video url in the upper text field, in which case the app will add that connection to your list of recent connections. Or you can choose a recent connection from the list. In both cases, press connect when you’re ready. 
At the moment, leave the json textfield empty to use localhost. 
