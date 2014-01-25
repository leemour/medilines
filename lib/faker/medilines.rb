module Faker
  module Medilines
    CHARACTERS = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'29').to_a

    def self.password
      (1..10).reduce('') {|a| a + CHARACTERS.sample }
    end

    def self.category
      cat = Product::NOUN.rand
      cat.size < 4 ? "#Large {cat}" : cat
    end

    def self.title
      Product::NOUN.rand
    end
  end
end