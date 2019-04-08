class WelcomeController < ApplicationController

    # methods inside controllers are called `actions`
    # so this is the `index` action
  
    def index
      # render "welcome/index"
      #  ð the line above is not needed in this case because it's 
      # executed by convention (default). By default, Rails will render a template
      # within a folder that has the controller name using a file that matches
      # the action name (index in this case) with a default extension of `.html.erb`
      # ERB is the default templating system that is shipped with Rail
    end
  end
  