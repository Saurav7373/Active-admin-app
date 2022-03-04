# frozen_string_literal: true

ActiveAdmin.register Post do
  sidebar :versionate, partial: 'layouts/version', only: :show
  # active_admin_paranoia
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  # #
  permit_params :title, :body, :user_id, :item
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
  action_item only: :index do
    link_to 'History'
  end
  # index do
  #   selectable_column
  #   id_column
  #   column :user
  #   column :title
  #   column :body
  #   column ("Admin Resource") { |v| v.item_type.underscore.humanize }

  #   column :created_at
  #   column :updated_at
  #   actions
  # end

  # show do
  #   attributes_table do
  #     row :user
  #     row :title
  #     row :body
  #     row :item_type
  #     # do |p|
  #     #   if p.item
  #     #     link_to p.item, [:admin, p.item]
  #     #   end
  #     # end
  #     row :created_at
  #     row :updated_at
  #   end
  #   active_admin_comments
  # end

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

    def show
      @post = Post.includes(versions: :item).find(params[:id])
      @versions = @post.versions
      @post = @post.versions[params[:version].to_i].reify if params[:version]
      @post.save
    end
  end

  member_action :history do
    @post = Post.find(params[:id])
    @versions = PaperTrail::Version.where(item_type: 'Post', item_id: @post.id)

    render 'layouts/historypost'
  end
end
