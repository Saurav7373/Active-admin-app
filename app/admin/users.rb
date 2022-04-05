# frozen_string_literal: true

ActiveAdmin.register User do
  sidebar :versionate, partial: 'layouts/version', only: :show
  # active_admin_paranoia
  # acts_as_paranoid
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :username, :phone, :file
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :phone, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs do
      f.input :username
      f.input :phone
    end
    f.inputs 'Do Import' do
      f.input :file, as: :file
    end
    f.actions
  end
  action_item only: :index do
    link_to 'Deleted', admin_users_deleted_record_path
  end
  # controller for users
  controller do
    def deleted_record
      render 'deleted_data', layout: 'active_admin'
    end
    # def create
    #   # render plain: params
    #   @errors = []
    #   successfull = 0
    #   unsuccessfull = 0
    #   if params[:user].key?(:file)
    #     csv_data = params[:user][:file]
    #     data = SmarterCSV.process(csv_data.tempfile,
    #                               { key_mapping: { row: nil, username: :username, phone: :phone, error: nil } })
    #     # data.each do |hash|
    #     #   # to check username presence in csv
    #     #   if hash.key?(:username)
    #     #     # for uniqueness
    #     #     if User.exists?(username: hash[:username])
    #     #       # error for uniqueness
    #     #       @errors << { 'row' => data.find_index(hash) + 1, 'username' => hash[:username], 'phone' => hash[:phone],
    #     #                    'error' => 'Username already exists' }
    #     #       unsuccessfull += 1
    #     #     else
    #     #       # @user = User.create(hash)
    #     ImportWorker.perform_async(data)

    #     #       # successfull += 1 if @user.save
    #     #     end
    #     #   # checking uniqueness of username
    #     #   else

    #     #     @errors << { 'row' => data.find_index(hash) + 1, 'username' => nil, 'phone' => hash[:phone],
    #     #                  'error' => 'Username cannot be blank' }
    #     #     unsuccessfull += 1

    #     #     # to store presence error
    #     #   end

    #     #   @user = User.create(hash)
    #     #   successfull += 1 if @user.save
    #     # end

    #   else
    #     User.create(permitted_params[:user])
    #     redirect_to admin_users_path
    #   end
    #   # flash[:notice] = "Imported Records: #{@a[successfull]}"
    #   # flash[:warning] = "Unimported Records: #{@a[unsuccessfull]}"
    #   # render 'user_import', layout: 'active_admin', locals: {errors:  values[@errors] }
    # end

    # def export
    #   @errors = params[:errors]
    #   respond_to do |format|
    #     format.csv { send_data User.to_csv(@errors) }
    #   end
    #   # redirect_to admin_users_paths
    # end

    # def show
    #   @user = User.includes(versions: :item).find(params[:id])
    #   @versions = @user.versions
    #   @user = @user.versions[params[:version].to_i].reify if params[:version]
    #   @user.save
    # end
  end

  member_action :history do
    @user = User.find(params[:id])
    @versions = PaperTrail::Version.where(item_type: 'User', item_id: @user.id)

    render 'layouts/historyuser'
  end
end
