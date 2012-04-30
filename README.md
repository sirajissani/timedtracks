timedtracks
===========

Keep a &#39;track&#39; of time!

Generates a shuffled playlists from a master collection which last for specified time. This script is inspired by [a lifehacker article](http://lifehacker.com/5877455/create-a-morning-playlist-to-make-sure-you-leave-on+time "Create a morning playlist to make sure you leave on time") which talks about creating specialized playlists to help you keep track of time in daily chores. I created this script to help me time my coffee/socializing breaks at office.

Note
----

This script currently only scans through an MPD database of songs stored as playlists and creates a random list of songs totalling a playtime of approximately the time specified. More information shall be added when time permits.

Usage
-----

    timedtracks.sh  hh:mm:ss  mpd_playlist_name


About MPD
---------

Please visit the [MPD wiki](http://mpd.wikia.com/wiki/Music_Player_Daemon_Wiki) for more informaiton.
