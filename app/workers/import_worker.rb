# frozen_string_literal: true

require 'sidekiq'
class ImportWorker
  include Sidekiq::Worker
  require 'smarter_csv'

  def perform(data)
    @errors = []
    successfull = 0
    unsuccessfull = 0
    count = 0
    data.each do |hash|
      count += 1
      # to check username presence in csv
      if hash.key?(:username)
        # for uniqueness
        if User.exists?(username: hash[:username])
          # error for uniqueness
          @errors << { 'row' => data.find_index(hash) + 1, 'username' => hash[:username], 'phone' => hash[:phone],
                       'error' => 'Username already exists' }
          unsuccessfull += 1
        else
          @user = User.create(hash)

          successfull += 1 if @user.save
        end
      # checking uniqueness of username
      else

        @errors << { 'row' => data.find_index(hash) + 1, 'username' => nil, 'phone' => hash[:phone],
                     'error' => 'Username cannot be blank' }
        unsuccessfull += 1

        # to store presence error
      end

      @user = User.create(hash)
      successfull += 1 if @user.save
    end
    unsuccessfull = count - successfull
    # UserNotifierMailer.send_import_email(successfull, unsuccessfull).deliver_now
  end
end
