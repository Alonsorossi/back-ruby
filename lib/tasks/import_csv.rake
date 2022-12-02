require 'csv'

namespace :import_csv do
  desc 'Import a csv file into db'
  task import_file: :environment do
    u = User.create!(name: 'Hating task again',
                     email: 'aaa@task.com',
                     dni: '74180009H',
                     password: 'password')

    File.readlines('./lib/tasks/facturas.csv').drop(1).each do |row|
      fields = row.split(';').map(&:strip)
      u.bills.create!(number: fields[1],
                      expdate: fields[2],
                      nifreceiver: fields[3],
                      concept: fields[4],
                      totalcount: fields[5],
                      niftransmitter: fields[0])
    end
  end
end
