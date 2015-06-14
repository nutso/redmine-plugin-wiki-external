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

## Installation

Follow standard Redmine plugin installation see http://www.redmine.org/projects/redmine/wiki/Plugins

NOTE: the directory for this plugin must be named "wiki_external" -- the path should be along the lines of #{REDMINE_ROOT}/plugins/wiki_external

## Configuration

### Global Settings

As a Redmine administrator, you can customize the global attributes via configuring Wiki External on the Administration/Plugins page.

* Wiki Prefix (required) -- this should be the full wiki prefix, excluding the wiki article/page identifier. Without a 
  valid value, the plugin will display an error directing you to configure this value every time someone wants to view a wiki page. 
  For out-of-the-box MediaWiki installations, an example would look like `http://wiki.mywebsite.com/index.php?title=`
  
* Wiki Suffix Custom Field Name (optional) -- if you want the ability to customize the wiki page prefix on a per-project basis, 
  you can set the project custom field name that you want to use to hold the wiki suffix here. See the section on Project Settings 
  below for information on setting the project-specific suffix values. If the project custom field does not already exist (in most
  cases it will not, but you may already have a field that you want to use), then you will need to add the project custom 
  field to your Redmine installation. The custom field type (text, integer, etc.) does not matter to the plugin, it only pulls
  the value, but in most cases a "text" attribute would be appropriate. 

### Project Settings

If the (optional) Wiki Suffix Custom Field Name attribute has been set in the plugin Global Settings, a project
administrator can use the named field to set the project-specific wiki suffix. In the case of MediaWiki installations, 
the wiki suffix equates to the wiki page name. 

If no value is provided in this field, or if this field is not configured for the system, then the project's identifier 
is used as the project-specific wiki suffix.

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

   rake redmine:plugins:migrate NAME=wiki_external VERSION=0 RAILS_ENV=production

2. Remove the plugin from the plugins folder (#{RAILS_ROOT}/plugins)

3. Restart Redmine (or web server)