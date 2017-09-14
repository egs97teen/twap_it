# Twap It #
## Built using Java, Spring Boot, and MySQL, Twap It is a recreation of Twitter which allows users to: write posts with a specified location, visualize trending posts on a map, and connect with other users. Built by Eric Sagata, Debbie Wang, Jonathan Carlson, and Scott Marden. ##

### Technologies: Java, JavaScript, Spring, MySQL, JSP, HTML, CSS3, jQuery, AJAX, and Bootstrap ###

*Twap It* is a simplistic recreation of Twitter written in **Java** that also utilizes **Google Maps API** to allow for data visualization based on a user's geographical location. *Twap It* was inspired by a group members' time spent assisting Syrian refugees in Jordan. The project was originally programmed to have a humanitarian focus, which only supported users plotting their location on a map whenever they were in a zone of conflict, or needed to report a sighting of specific health conditions (i.e. the spread of polio). Messages were stored in the database, along with a tag specifying the type of danger they were in. Eventually, to add global appeal to the application, *Twap* It was upgraded to support general hashtag functionality in order to allowing users to not be limited in the type of content they wish to 'Twap' from any location.

The database is designed using **MySQL**, in order to support relationships between user models and 'Twap' models, as well as relationships between users. Combined use of **AJAX**, **jQuery**, and queries run using **JPQL**, allow the site to have user search functionality and social media attributes.

Through use of **Google Maps Geolocation** and **Geocoding** services, users can choose to write a 'Twap,' which will also register the user's current location, or a location of their choosing on the map. All 'Twaps' are marked on the map upon loading, and are clustered according to location if multiple 'Twaps' are registered in the same area. Users have the option to filter the 'Twaps' they wish to see on the map by a specific hashtag.

**Spring Security** enables users to also be registered as either administrators or general users. Administrators have the capability of initializing various CRUD operations, such as deleting 'Twaps' or users. Users are only able to delete their own 'Twaps.'
