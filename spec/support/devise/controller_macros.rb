module Devise::ControllerMacros
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    user.confirm
    sign_in user
  end
end
