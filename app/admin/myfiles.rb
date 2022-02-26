# frozen_string_literal: true

ActiveAdmin.register Myfile do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :image, :title
  #
  # or
  #
  # permit_params do
  #   permitted = [:image, :title]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Image upload' do
      # f.input :title
      f.input :title, collection: Myfile.all, include_blank: true
      # filter :title, as: :select2_multiple, collection: [:apples, :bananas, :oranges]

      if f.object.image # loads if validation fails and also acts as a edit form
        f.input :image, as: :hidden, input_html: { value: f.object.image_data } # holds previously selected file data
        f.input :image, as: :file, label: 'File',
                        hint: image_tag(f.object.image.url, width: 100, height: 100, title: f.object.image.original_filename)
      else
        f.input :image, as: :file, label: 'File'
      end
    end
    # f.inputs 'Upload Files' do
    #   f.file_field :image

    # end
    f.actions
  end
  index do
    selectable_column
    id_column
    column :title
    column :Files do |p|
      # ul do
      # p.image.each do |m|
      # li do
      image_tag p.image.url, width: 150, height: 150, title: p.image.original_filename

      # end
      # end
      # end
      # end
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :title
      row :Files do |p|
        # ul do
        # p.image.each do |m|
        # li do
        image_tag p.image.url, width: 150, height: 150, title: p.image.original_filename
        # end
        # end
        # end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
