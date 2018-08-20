class Api::V1::ProfilesController < ApplicationController
  respond_to :json

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      render json: {status: 200, message: "Profile Successfully Created", profile: @profile}
    else
      render json: {status: 400, error: @profile.errors}
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :email, :address, :cell_phone_number, :home_phone_number, :street_address, :island, :gender, :date_of_birth)
    end
end