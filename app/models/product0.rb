#encoding: utf-8
class Product
  include Mongoid::Document
  field :slug, type: String
  field :title, type: String
  field :brand, type: String
  field :type, type: String
  field :price, type: Integer
  field :country, type: String
  field :options, type: Array
  field :features, type: Array
  field :description, type: String
  field :excerpt, type: String
  field :slogan, type: String
  
  validates :title, presence: true#, error: 'Не может быть пустым'
  #validates_presence_of :attribute, on: :create, :message => 'Не может быть пустым'
end
