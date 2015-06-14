require 'redmine'

# models
# controllers
require 'wiki_controller_patch'
# views

Redmine::Plugin.register :wiki_external do
  name 'Wiki External'
  author 'Teresa N.'
  author_url 'https://github.com/nutso/'
  url 'https://github.com/nutso/redmine-plugin-wiki-external'
  description 'Forces the use of an external wiki (e.g. separate MediaWiki installation).'
  version '1.0.0'
  
  # user-accessible global configuration
  settings :default => {
    'wiki_base_url' => nil,
    'wiki_project_custom_suffix_field' => nil
  }, :partial => 'settings/wiki_external_settings'
  
  # Send patches to models and controllers
  Rails.configuration.to_prepare do
    WikiController.send(:include, RedmineWikiExternal::WikiControllerPatch)
  end  
end