FactoryBot.define do
  factory :diary do
    content1 { 'content1' }
    content2 { 'content2' }
    content3 { 'content3' }
    allow_publication { true }
    allow_comments { true }
  end
end
