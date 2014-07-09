iOS Application
====
This is iOS application built for my Final Year Project.
This application works in conjunction with a Java server application which is also posted on this GitHub account.

The aim of the project was to allow users to view Tweets posted within their surrounding location on a map.

The application captures a users location and sends it to a server application using a HTTP request. This occurs in the ViewController class. When data is received back to this class from the server, the MapViewController class is called and sent the received data. In this class a mapView is created and the Tweet data displayed on it.

The relevant code is stored in the REST folder on this repository.
