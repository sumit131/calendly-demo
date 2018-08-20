ActiveAdmin.register Profile do

  permit_params :first_name, :last_name, :email, :address, :cell_phone_number, :home_phone_number, :street_address, :island, :gender, :date_of_birth

  form do |f|
    f.inputs "Profile Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :address
      f.input :cell_phone_number
      f.input :home_phone_number
      f.input :street_address
      f.input :island
      f.input :gender, :as => :select, :collection => ["Male", "Female", "Other"]
      f.input :date_of_birth
    end
    f.actions
  end
end
