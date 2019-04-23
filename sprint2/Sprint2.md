# Functional Requirements Refinement
---------------------

# System Design Document
---------------------

# UI Design
---------------------

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

# Changed Files
---------------------
