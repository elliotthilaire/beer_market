# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController
    model :store

    def index
      # Add code for when the index view is loaded
    end

    def add_drink
      drinks << { name: page._new_drink_name, price: page._new_drink_price }

      page._new_drink_name = ''
      page._new_drink_price = ''
    end

    def purchase(drink)
      # add to purchase history
      local_store._purchases << { time: Time.now, name: drink._name, price: drink._price }

      increase_price(drink)
      decrease_prices
    end

    def clear_purchases
      local_store._purchases.reverse.each do |purchase|
        purchase.destroy
      end
    end

    private

    def increase_price(drink)
      drinks.count.then do |count|
        drink.price += count
      end
    end

    def decrease_prices
      drinks.each do |drink|
        drink.price -= 1
      end
    end

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end
