class Drink < Volt::Model
  field :name, String
  field :price, Fixnum

  validate :price, presence: true
  validate :name, presence: true
end
