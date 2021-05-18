require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'has many action plans' do
    it 'should be valid' do
      user = FactoryBot.create(:user)
      user.posts.create(introduction_title:"はじめに")
      action = Action.create(conclusion:"ok")
      apost = user.posts.first
      apost.action_plans.create(action_id: action.id )
      expect(apost.action_plans.exists?).to eq(true)
    end
  end
end
