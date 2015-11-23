require 'rails_helper'
include RandomData

RSpec.describe Rating, type: :model do

  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user)  { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:post)  { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:rating) { Rating.create!(name: 'PG') }

  it { should have_many :raterings }
  it { should have_many :topics }
  it { should have_many :posts }

  describe "rateable" do
    it "allows the same rating to be associated with a different topic and post" do
      topic.ratings << rating
      post.ratings << rating

      topic_rating = topic.ratings[0]
      post_rating   = post.ratings[0]

      expect(topic_rating).to eql(post_rating)
    end
  end

  describe ".update_rating" do
    before do
      @another_post = Post.new(title: "My post title", body: "My awesome post body which fulfills requirements", user: user)
    end

    it "updates the rating to a severity value" do
      rated_post = @another_post.ratings.create
      expect(rated_post).to eq(rating)
      @another_post.save
    end
  end
end