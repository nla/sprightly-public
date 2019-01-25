# Sprightly

*Note:* This is an old (2010) fork of the internal Sprightly codebase. The dependencies on other NLA internal systems
were stubbed out so that this could be run standalone. The NLA does not intend to maintain this fork.

## Introduction

The purpose of the rights management system is to collect all rights information in one place and make it accessible to Library staff. Rights information includes copyright status of works and access/use agreements with rights holders.

The first version of the rights management system was developed in 2007-2008 and allowed recording of rights information for the Library's digital collection items and rights holders. The paper Developing a rights management system for the National Library of Australia's collections provides more information about this project. The current version of the rights management system, developed in 2009, allows staff to record agreements with rights holders for material in both the digital and physical collections. Staff can also view an automated calculation of copyright status for works in the collection based on information in catalogue records.

The high level requirements for this system were:

* easy and efficient input of rights information about works and rights holders
* easy and efficient discovery and interpretation of this information
* make use of relevant existing metadata in other systems

## Installation

The application is built in Ruby on Rails.

Application
git clone git://code.nla.gov.au/sprightly
There are two rails applications

* sprightly-public : The core application
* sprightly-services : Mocked services

To run the application:

* Go into the sprightly-public directory and run: ruby script/server
* Go into the sprightly-services directory and run on a different port: ruby script/server -p 9191

### Database
Install Oracle Express
Create a tablespace called rms_os
Import the database using the file rms_os.sql

Datamodel

## Usage
Application login details:

* Administrator: user=admin, password=123
* Updater: user=kangaroo, password=123
* View: user=emu, password=123

Use the following searches for Rightsholders and the Catalogue:

* "Nick Cave"
* "Kylie Minogue"
