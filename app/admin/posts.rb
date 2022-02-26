# frozen_string_literal: true

ActiveAdmin.register Post do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  # #
  permit_params :title, :body, :user_id
  #
  #   column :title
  #   column :body
  #   column(:user) { |post| post.user.user_username }
  #   # column('body', humanize_name: false) # preserve case
  # end

  form do |f|
    f.inputs do
      f.input :user, include_blank: false, input_html: { id: 'post' }
      f.input :title
      f.input :body
    end
    f.actions
  end
  controller do
    # def new
    #   @users   = User.where(username: 'gopal').pluck(:username, :id)
    #   render plain: @users

    # end

    def create
      @user_check = User.find_by(id: permitted_params[:post][:user_id])
      if !@user_check.present?
        @user = User.create(username: permitted_params[:post][:user_id])
        @post = Post.create(title: permitted_params[:post][:title],
                            body: permitted_params[:post][:body],
                            user_id: @user.id)
      else
        permitted_params[:post][:user_id] = @user_check.id
        @post = Post.create(permitted_params[:post])
      end
      if @post.save
        redirect_to admin_posts_path
      else
        render :ok
      end
    end
  end
end
