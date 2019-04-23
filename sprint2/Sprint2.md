# Functional Requirements Refinement
---------------------
We don't believe it is necessary to refine our functional requirements at this time, as our stakeholder hasn't had a problem with our current direction so far.

# System Design Document
---------------------
![Sprint 2 Design Document PNG](https://github.com/computationalmystic/augur-group13/blob/master/sprint2/sprint2designdoc.png "Sprint 2 Design Document")

# UI Design
---------------------
[This section is written by Paul Gillis]
I decided to convert the augur UI design into Lunacy (Sketch for Windows) for ease later on. Lunacy is a design program used for designing websites and mobile apps, I choose to put our symbols in Lunacy since the program can later export the assets into css. Keeping with the KUBE styleguide I used the bordered labels. The different states for Redistribution are Approved (Green) and Rejected (Red). The Redistribution is accompanied by a second enum representing the redistribution requirements. It's different states are Requires Author Recognition (Blue) and Recognition Not Required (Blue). The second enum metric Software Warranty has two states No Warranty (Red) and Valid up to #days (Green). More metrics are to come/in discussion amunst the team.
Lunacy File: Augur.sketch
Current UI Design: AugurUI.png

# Data
---------------------
[This section written by Carter Landis]
We had some technical difficulties getting DoSOCSv2 fully installed on our ec2 instance. There were a few problems:

1. I'm in charge of system and database administration, and I use a Mac, while DoSOCSv2 is only installable on Linux since it uses a few Linux specific libraries. As a result, local installation/testing was impossible.
2. Our ec2 instance is of the "micro" tier, meaning there is not lots of space available. More than once the server had to be restarted or cleared to make room for installations or to clear accumulated temp files. I don't have AWS credit or feel that I should have to pay for more space for my use case, so upgrading is not an option. 
3. For a while, Git was just straight failing to clone the repo due to a compression setting requiring more memory than available. This was eventually fixed, but not without some frustration.
4. To install `nomos`, the file scanner used by DoSOCSv2, FOSSology either must be installed, or temporarily cloned as part of the DoSOCSv2 installation process. This means that the whole of DoSOCSv2 is dependent on FOSSology, so if that installation doesn't work, DoSOCSv2 never will. I tried to install FOSSology, but that didn't work either (see item 6).
5. The `install-nomos.sh` script in the `scripts` folder of DoSOCSv2 does not work. Specifically, it fails to properly install `nomos` due to not being able to find `-lfossology` in order to link FOSSology's instalaltion of `nomos` to the DoSOCSv2 version. I tried editing the script itself to address item 7, but was unable to make this work as well.
6. The installation of FOSSology seemed to work, but when attempting to use the program, I was unable to do so. I thoroughly combed the logs of ALL the install processes, and found no significant errors that would indicate why the installation might not have been successful. As a result, I could not get `nomos` installed, nor could I figure out why it wouldn't install. No documentation existed on why it might not have worked.
7. I could only find exactly one mention of the specific error I was having, and the proposed solution (running `make` and then `sudo make install` inside the `src` directory of the `fossology` folder) did absolutely nothing to resolve the error.

If I could just get DoSOCSv2 to actually install `nomos`, then everything would be fixed. Without this piece, however, DoSOCSv2 is useless. Both myself and my group member Luke have been to office hours at least 3 times each to try and get this issue resolved. 

As a result of all of these problems, since I was unable to fully install DoSOCSv2, I was not able to complete the data section by filling it with bogus data. However, we do have the PostgreSQL queries for creating [this](dosocs.png) schema available [here](dosocs.sql). Our ERD has not changed.

# Coding
---------------------
[This section written by Luke Fisher]
My long term objective is to wrap DoSOCSv2 in a flask server. To this end I installed DoSOCSv2 on my local machine and created a basic proof of concept program. I have documented some of my many obsticles and my achievements below:

1. I have essentially no Python experience prior to this course. While this may seem like it was a bit of a non-factor when looking at the Python program I wrote, it took a few hours to figure out what was going on under the hood with Flask and Python. 
2. DoSOCSv2 was an absolute nightmare to install. I had to install a new operating sytem, install and micro-manage a multitude of dependencies, and apply a few dirty hacks to a few files to get it up and running. I became a regular at Professor Goggins' office hours with several odd and mundane issues that he helped me sort out.
3. Once I had a novice grasp of Python/Flask and a working instance of DoSOCSv2, I created a simple proof-of-concept Flask wrapper for DoSOCSv2. It literally outputs a hardcoded dosocs2 command's result to the webpage, but it works and it provides a base from which to build off of. 

The next steps for me will be fleshing out my wrapper on my local machine while Carter gets a working version of DoSOCSv2 on our server. Then I will work with Paul on the Augur API.

# Changed Files
---------------------
- Added Luke's basic DoSOCSv2 wrapper in `dosocsv2wrapper/main.py`
