require 'rails_helper'

RSpec.describe Comment, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject { Comment.new(text: 'Hello World') }
  before { subject.save }

  it 'comment_counter method should raise error without post' do
    expect { subject.comment_counter }.to raise_error(NoMethodError)
  end
end
