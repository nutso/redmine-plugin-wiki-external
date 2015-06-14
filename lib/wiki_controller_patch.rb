module RedmineWikiExternal
  # Note: Redmine's "WikisController" (plural) is used to control the overall wiki
  # The "WikiController" (singular) is used to control the wiki pages/content
  # The only wiki controller hook in core is for after save
  module WikiControllerPatch
    def self.included(base)
      base.class_eval do
        # redefine the routing methods

        # core/new - not used
        
        # core/create - not used
        
        # core/index - shows a list of WikiPages grouped by page or date
        def index
          redirect_to action: "show"
        end
        
        # core/show - will also show the form for creating a new wiki page
        def show
          redirect_to "#{plugin_wiki_external_base_url}#{plugin_wiki_external_project_suffix}"
        end

        # These actions are never visible once 'show' is overriden; not overriding to keep the 
        # plugin interference minimal
        # core/edit - used to edit an existing or new page
        # core/update - used to save a wiki page update to the database, including new pages
        # core/destroy - normal
  
        def plugin_wiki_external_project_suffix
          unless(Setting.plugin_wiki_external['wiki_project_custom_suffix_field'].empty?)
            # check to see if our project custom field exists (optional)
            field = ProjectCustomField.where(:name => Setting.plugin_wiki_external['wiki_project_custom_suffix_field'])
            if(field.any?)
              # check for project-specific value
              value = CustomValue.where(:custom_field_id => field.first.id, :customized_id => @project.id)
              if value.any?
                return value.first.value unless value.first.value.empty?
              end
            end
          end
          
          # default value if either not globally configured
          # or this project's wiki identifier is not set
          @project.identifier
        end
  
        def plugin_wiki_external_base_url
          # clean up the setting ... not sure if there's a way to control it better on save?
          # TODO more cleanup ... ?
          
          if Setting.plugin_wiki_external['wiki_base_url'].empty?
            # TODO hmm ... use redmine root?
             Setting.plugin_wiki_external['wiki_base_url'] = "http://localhost/"
          end
          
          Setting.plugin_wiki_external['wiki_base_url']
        end
                
      end # base.class_eval
    end # self.included
  end # project controller patch
end # project priority
