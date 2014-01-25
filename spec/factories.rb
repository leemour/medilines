require 'ffaker'
require 'faker/medilines'

# require 'database_cleaner'
# DatabaseCleaner.strategy = nil

include ActionDispatch::TestProcess

model_statuses = ['published', 'draft']
sample_images = Dir.glob(File.join(Rails.root, 'spec', 'sample_images', '*'))

FactoryGirl.define do
  factory :product do
    name          { Faker::Product.product_name }
    slug          { name ? name.parameterize : nil }
    status        { model_statuses.sample }
    sequence(:position)
    brand
    category
    price         { Random.new.rand(20..100) * 1000 }
    features      { Faker::Lorem.sentence 10 }
    description1  { Faker::Lorem.sentences(3).join ' ' }
    description2  { Faker::Lorem.sentences(3).join ' ' }
    slogan        { Faker::Lorem.sentence 5 }
    image         { fixture_file_upload sample_images.sample }
  end

  factory :brand do
    name          { Faker::Product.brand + " ltd" }
    slug          { name ? name.parameterize : nil }
    country       { Faker::Address.country }
    slogan        { Faker::Lorem.sentence 5 }
    description   { Faker::Lorem.sentence }
    logo          { fixture_file_upload sample_images.sample }
    # image         { fixture_file_upload sample_images.sample }
    # flag          { fixture_file_upload sample_images.sample }
  end

  factory :category do
    name          { Faker::Medilines.category }
    slug          { name ? name.parameterize : nil }
    description   { Faker::Lorem.sentence }
    logo          { fixture_file_upload sample_images.sample }
    after(:create) do |category|
      unless category.parent_id
        category.parent = build(:category, :parent_id => 1)
      end
    end
  end

  factory :page do
    title         { Faker::Lorem.word + ' Page' }
    slug          { title ? title.parameterize : nil }
    intro         { Faker::Lorem.sentence 10 }
    content       { Faker::Lorem.sentences(5).join ' ' }
    status        { model_statuses.sample }

    trait :published do
      status 'published'
    end
  end

  factory :promotion do
    title         { Faker::Medilines.title }
    slug          { title ? title.parameterize : nil }
    content       { Faker::Lorem.sentences 5 }
    status        { model_statuses.sample }
  end

  factory :admin_user do
    email         { Faker::Internet.email }
    password      { Faker::Medilines.password }
  end
end
