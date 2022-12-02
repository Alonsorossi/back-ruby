namespace :generate_user do
  desc 'Creating a new user'
  task user_task: :environment do
  User.new(name: 'Task User', email: 'task@task.com', dni: '74180009H', password: '12345')
  end
end
