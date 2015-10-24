module Admin
  class MainController < Volt::ModelController

    model :store

    def index
      # Add code for when the index view is loaded
    end

    def add_drink
      drinks.create( { name: page._new_drink_name, price: page._new_drink_price } )
        .then do 
          page._new_drink_name = ''
          page._new_drink_price = ''
        end
        .fail do |err|
          flash._errors << "Unable to save because #{err}"
        end
    end

    private

    # the main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._controller and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end
  end
end