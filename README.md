# redmine-plugin-wiki-external

~~ This plugin is *not* ready for prime-time yet. Feedback/testing/contributions always welcome! ~~

Redmine plugin that forces the use of an external wiki (e.g. separate MediaWiki installation) instead of the internal Redmine wiki.

This does *NOT* import information from the wiki; primarily it overwrites navigation so all wiki links point to the external wiki.

Released under GPLv2 in accordance with Redmine licensing.

## Features

Use an external wiki instead of Redmine's internal wiki. This is helpful when you already have a wiki system in place before using Redmine,
or you want to control wiki and documentation access differently that for a given Redmine project (e.g. if Redmine is internal-only and
the wiki is globally accessible).

Currently this plugin has been tested on MediaWiki.

Note that the ability to list wiki pages for a given Redmine project is NOT available with external wikis. You will need to enable
this feature on your wiki platform itself (e.g. the SubPageList extension for MediaWiki).

Also note that Redmine's project identifier is used as the base wiki page on the external platform (at least for now, this is not
customizable). If you want to use a different wiki page name as the base for the wiki, you will need to create an auto redirect
on the external wiki page itself (e.g. #REDIRECT directive for MediaWiki).

## Installation

Follow standard Redmine plugin installation see http://www.redmine.org/projects/redmine/wiki/Plugins

NOTE: the directory for this plugin must be named "wiki_external" -- the path should be along the lines of #{REDMINE_ROOT}/plugins/wiki_external

## Configuration
     
N/A
   
## Upgrade or Migrate Plugin

Please check the Release Notes (ReleaseNotes.md) for substantive or breaking changes.

### Option 1: Git Pull
If you installed via git clone and are tied to the master or develop branch (you daredevil you!), you can just change to 
the wiki_external directory and do a git pull to get the update

Then, re-run the database migrations (don't forget to make a backup first!) and restart Redmine, similar to the initial 
installation (reference http://www.redmine.org/projects/redmine/wiki/Plugins)

### Option 2: Remove and Re-install Plugin
1. Follow Remove or Uninstall Plugin instructions below
2. Follow Installation instructions above
   
## Remove or Uninstall Plugin

Follow standard Redmine plugin un-installation -- (barely) modified from http://www.redmine.org/projects/redmine/wiki/Plugins

1. Downgrade the database (make a db backup before)

   rake redmine:plugins:migrate NAME=project_priority VERSION=0 RAILS_ENV=production

2. Remove the plugin from the plugins folder (#{RAILS_ROOT}/plugins)

3. Restart Redmine (or web server)