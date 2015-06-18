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
    'wiki_project_custom_suffix_field' => nil,
    'show_wiki_home_in_app_menu' => false,
    'wiki_home_caption' => :project_module_wiki
  }, :partial => 'settings/wiki_external_settings'
  
  
  Redmine::MenuManager.map :application_menu do |menu|
    menu.push :wikis, { :controller => 'wikis', :action => 'index' }, :caption => Settings.plugin_wiki_external['wiki_home_caption'], :if => Proc.new { (Setting.plugin_wiki_external['show_wiki_home_in_app_menu'] == "1")}
  end

  
  # Send patches to models and controllers
  Rails.configuration.to_prepare do
    WikiController.send(:include, RedmineWikiExternal::WikiControllerPatch)
  end  
end