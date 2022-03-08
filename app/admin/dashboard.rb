# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }
  content title: proc { I18n.t('active_admin.dashboard') } do
    panel 'Recently updated content' do
      table_for PaperTrail::Version.order(id: :desc).limit(nil) do # Use PaperTrail::Version if this throws an error
        @index = ((params[:page] || 1).to_i - 1) # 30 needs to set to that what your page size @index = 30*(((params[:page] || 1).to_i) - 1)
        column :number do
          @index += 1
        end

        column('Item ID', &:item_id)
        column('Item', &:item)
        # column ("Item") { |v| link_to v.item, [:admin, v.item] } # Uncomment to display as link
        column('Admin Resource') { |v| v.item_type.underscore.humanize }
        column('Action') { |v| v.event.underscore.humanize }
        # column('Changed by') do |v|
        #   link_to AdminUser.find_by_id(v.whodunnit), [:admin, AdminUser.find_by_id(v.whodunnit)]
        # end
        column('Modified at') { |v| v.created_at.to_s :long }
      end
    end
  end
end
