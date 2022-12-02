FactoryBot.define do
  factory :bill do
    sale_date { Faker::Date.between(from: '1990-01-01', to: '2022-01-01') }
    status { 'eraser' }
    niftransmitter { '50627511A' }
    nifreceiver { '50627511A' }
    concept { Faker::Job.title }
    totalcount { Faker::Number.decimal(l_digits: 2) }
  end
end
