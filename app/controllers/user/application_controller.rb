class User::ApplicationController < ApplicationController
  before_action :authenticate_user!
end
