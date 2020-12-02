# big-things
An iOS based application

## Spec
Big Things
Big Things are a series of oversized roadside attractions located around Australia. These serve as landmarks, indicators of sites of interest, and as drawcards in their own right for those fascinated by their existence. Many people (myself included) enjoy visiting the Big Things, and when travelling always make sure to detour to see any which may be on the way.

For more information about Big Things and to get pictures and data for testing, visit the Wikipedia page at: https://en.wikipedia.org/wiki/Australia%27s_big_things

The gaol is to build an app that fans of Big Things can use to identify any Big Things in their region, view and submit ratings, and track which Big Things they have visited. Accordingly, the app has six main functions:

List of Big Things
List all of the known Big Things (by "known", I mean "known by the app"). As Big Things come and go, this list will be downloaded from an online database using an API (to be provided) which will be regularly updated by tracking the status of vairous Big Things, adding new Big Things to the list, and updating information and ratings about each Big Thing.

If this was searchable by name and State, and sortable (by name and rating) that would be great.

Display a Big Thing
Normally accessed through the List of Big Things, this displays details about a Big Thing - in particular, a photo, the name, the location, a short description and the rating and tags (see below). All of this data will be downloaded per the list of Big Things.

Rate and Track a Big Thing
If the user has visited a Big Thing they should be able to mark it as seen. If they have Big Things they particularly like, they should be able to tag it as a favourite. Both of these will ideally be saved locally on the app. However, the user should also have an option of rating a Big Thing (0 to 5 stars), and that rating will be submitted (using the API) to a website, to be added to an overall rating.

Note that for our purposes we will use a trust system, and assume that each user only rates a Big Thing once. In a production version we would add tools to prevent one person rating the same site multiple times.

About Big Things
General information about Big Things. At this stage we're just going to use text from Wikipedia:

The big things of Australia are a loosely related set of large structures, some of which are novelty architecture and some are sculptures. There are estimated to be over 150 such objects around the country. There are big things in every state and territory in continental Australia. Most big things began as tourist traps found along major roads between destinations. The big things have become something of a cult phenomenon, and are sometimes used as an excuse for a road trip, where many or all big things are visited and used as a backdrop to a group photograph. Many of the big things are considered works of folk art and have been heritage-listed, though others have come under threat of demolition.

Big Things Near Me
This is only needed for higher grades (see the breakdown below) but using the iOS location services and the GPS coordinates provided from the server, display a map showing Big Things in the area.

Submit a Big Thing
If a user finds a new Big Thing not in the database, they should be able to submit (using the API) some basic data: the name, GPS coordinates (if you have location services working) or an address (if you don't), time and date it was seen (automatically calculated), the user's name (optional, but used to give them credit) and (optionally) a photo. That last one does not need to be sent to the API, although the API will be able to accept one - choosing one from the Camera Roll will be regarded as sufficient for full marks whether or not it is sent.
