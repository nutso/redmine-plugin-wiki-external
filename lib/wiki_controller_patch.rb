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
          redirect_to "#{plugin_wiki_external_base_url}#{@project.identifier}"
        end

        # TODO core/edit - used to edit an existing or new page
        # TODO core/update - used to save a wiki page update to the database, including new pages
        # TODO core/destroy - normal
  
        # TODO private?
        def plugin_wiki_external_base_url
          # clean up the setting ... not sure if there's a way to control it better on save?
          # TODO more cleanup
          
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
