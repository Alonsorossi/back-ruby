class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
     



      ## Recoverable
       t.string :reset_password_token
       t.datetime :reset_password_sent_at

      ## Trackable
      # t.string :last_sign_in_ip
      # t.datetime :last_sign_in_at
      # t.string :last_request_ip
      # t.datetime :last_request_at

      ## Invitable
      # t.string :invitation_token
      # t.datetime :invitation_sent_at
      # t.datetime :invitation_accepted_at

      ## Lockable
      # t.integer :failed_attempts
      # t.string :unlock_token
      # t.datetime :first_failed_attempt_at
      # t.datetime :locked_at
    end
  end
end
