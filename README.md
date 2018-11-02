# Cucumber Linux Ports Tree 2.0
Welcome to the Cucumber Linxu Ports Tree 2.0. This ports tree has been completely rewritten from scratch: it contains none of the code from the Cucumber Linux 1.x ports tree. It will eventually replace the ports tree found in Cucumber Linux 1.0/1.1.

## IMPORTANT NOTE about Cloning this Repository
Many of the utilities in this repository expect the repository to be located in /usr/ports, so it is strongly recommended that you either clone it into /usr or make a symlink from /usr/ports pointing to the location you cloned it to. Alternatively, you may use the portstrap script (located at utilities/tools/portstrap) to automatically clone the repository to the correct location and set up the necessary files.

## How to Build Packages
Documentation on how to build the packages in this ports tree is located in the ports/utilities/documentation/building-packages file.

## Directory Structure
The ports tree is broken down into three subdirectories: cucumber, community and utilities.

### /cucumber
Contains the source directories for the packages found in the official Cucumber Linux binary distribution. This directory is maintained by the Cucumber Linux core development team.

### /community
Contains the source directories for additional packages not provided as part of the official binary distribution. These packages are maintained by individual community members and consequentially are held to lower standards than the packages in the /cucumber directory.

### /utilities
Contains various utilities for creating, maintaining and modifying ports. Also contains the ports system documentation and templates. This directory does not contain any packages.
