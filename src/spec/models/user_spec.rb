require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(
        email: "aaa@gmail.com",
        password: "testpass",password_confirmation: "testpass",
        name: "taro", profile_text: "dfsf",
        image: "fd",activated: true, activated_at: Time.zone.now )
  end

  context 'All Relation' do
    it 'should be ok' do
      @user.save
      @user.posts.create(introduction_title:"はじめに", introduction?: true, introduction_text:"こんにちは",
                        tag_id: 1 )
      tag = Tag.create(tag:"ニキビ")
      post = @user.posts.first
      tag_hub = TagHub.create(tag_id: tag.id, post_id: post.id)
      like = @user.likes.create(post_id: post.id)
      action = Action.create(step:1, conclusion:"顔あらえ", description: "すっきりするじゃん")
      action_plan = post.action_plans.create(action_id: action.id)
      expect(post.valid?).to eq(true)
      expect(tag.valid?).to eq(true)
      expect(tag_hub.valid?).to eq(true)
      expect(like.valid?).to eq(true)

      expect(action.valid?).to eq(true)
      expect(action_plan.valid?).to eq(true)
    end
  end


  context 'valid value' do
    it 'can be created' do
      expect(@user.valid?).to eq(true)
    end
    it 'valid email should accept' do
      valid_addresses = %w[user@example.com USER@foo.com
        A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user.valid?).to eq(true)
      end
    end
  end
  context 'invalid value' do
    it 'empty name cannot be created' do
      @user.name = ""
      expect(@user.valid?).not_to eq(true)
    end
    it 'too long cannot be created'  do
      @user.name =  "a"*255
      expect(@user.valid?).not_to eq(true)
    end
    it 'invalid email should not accept' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user.valid?).not_to eq(true)
      end
    end
    it 'email addresses should be unique' do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase #大文字と小文字の違いは無視されないといけない
      @user.save
      expect(duplicate_user.valid?).not_to eq(true)
    end
    it 'password length under 8 shuld not be accepted' do
      @user.password = @user.password_confirmation = "a"*7
      @user.password_confirmation = "a"*7
      expect(@user).not_to be_valid
    end
    it 'password cannot allow empty' do
      @user.password = @user.password_confirmation = " "*10
      expect(@user).not_to be_valid
    end
  end

  scenario 'when User not have remember digest login, it should be failed' do
    expect(@user.authenticated?('', "remember")).to be false
  end

end
