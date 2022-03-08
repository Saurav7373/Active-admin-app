# frozen_string_literal: true

ActiveAdmin.register Post do

  # scope "All Record", :with_deleted, default: true
  scope 'Non Deleted Record', :without_deleted, default: true
  # scope "Deleted Record", :only_deleted,->{ where only_deleted: true }
  # scope :without_deleted

  # for rendering sidebar in views for checking versions
  sidebar :versionate, partial: 'layouts/version', only: :show


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


  filter :user
  filter :title
  filter :body

  index do
    selectable_column
    id_column
    column :user
    column :title do |tex|
      truncate(tex.title, length: 22)
    end
    column :body do |bod|
      truncate(bod.body, length: 22)
    end
    column :created_at
    column :updated_at
    actions name: 'Actions'
  end

  action_item only: :index do
    button style: 'background-blend-mode: unset; text-shadow: none' do
      strong(link_to('Deleted Records', admin_posts_deleted_record_path,
                     style: 'color: white; text-decoration: none'))
    end
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
    # for rescuing the unique
    rescue_from PG::UniqueViolation, with: :show_errors

    def show_errors
      flash[:info] = 'Already exist. Cannot make duplicate.'

      redirect_to admin_posts_path
    end

    def scoped_collection
      @post = Post.without_deleted
    end

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

      # @post.save
    end

    # for updating content from papertrail save for previous version
    def paper_update
      # render plain: params
      @post = Post.includes(versions: :item).find_by(params[:id])
      @versions = @post.versions
      @post = @post.versions[params[:version].to_i].reify if params[:version]
      @post.save!
      redirect_to admin_posts_path
    end

    def deleted_record
      render 'deleted_data', layout: 'active_admin'
    end

    # for hard deleting of posts
    def destroy_data
      @post = Post.only_deleted.find_by(params[:id])
      @post.really_destroy!
      flash[:alert] = "#{@post.title} is Permanently Deleted"
      render 'deleted_data', layout: 'active_admin'
    end

    def restore
      @post = Post.only_deleted.find_by(params[:id])
      @post.restore
      flash[:notice] = "#{@post.title} is Restored"
      redirect_to admin_posts_path

      @post.save

    end
  end

  member_action :history do
    @post = Post.find(params[:id])
    @versions = PaperTrail::Version.where(item_type: 'Post', item_id: @post.id)

    render 'layouts/historypost'
  end
end
