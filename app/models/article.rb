class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :authors, through: :taggings, dependent: :destroy

  def author_list
    list = []
    authors.each {|a| list.push(a.name)}
    list.join(", ")
  end
  def author_list=(author_str)
    list = author_str.split(", ")
    uniqs = list.map {|a| a.strip.capitalize}.uniq

    cleans = uniqs.map {|a| Author.find_or_create_by(name: a)}
    self.authors = cleans
  end
end
