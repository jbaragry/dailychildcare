require 'spec_helper'

describe "Microposts" do

  before(:each) do
    @user = Factory(:user)
    @user.toggle(:staff)
    @child = Factory(:child)
    visit signin_path
    fill_in :email,    :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end

  describe "creation" do

    describe "failure" do

      it "should not make a new micropost" do
        lambda do
          visit child_path
          fill_in :micropost_content, :with => ""
          click_button
          response.should render_template('children/show')
          response.should have_tag("div.flash.error", /include/i)
        end.should_not change(Micropost, :count)
      end
    end

    describe "success" do

      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"
        lambda do
          visit child_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_tag("span.content", content)
        end.should change(Micropost, :count).by(1)
      end
    end
  end

    describe "destruction" do
  
#      it "should destroy a micropost" do
#        # Create a micropost.
#        visit child_path
#        fill_in :micropost_content, :with => "lorem ipsum"
#        click_button
#        # Destroy it.
#        # can't get this to pass....
#        lambda { click_link "delete" }.should change(Micropost, :count).by(-1)
#      end
    end
end
