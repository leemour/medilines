require 'spec_helper'

describe Statusable do
  before do
    stub_const 'Foo', Class.new(ActiveRecord::Base)
    Foo.class_eval do
      include Statusable
      status published: "опубликовано", draft: "черновик"
    end
  end

  describe '#status' do
    it 'sets #statuses for a model' do
      Foo.statuses.should == { published: "опубликовано", draft: "черновик" }
    end
    it "can't be run multiple times" do
      expect { Foo.status published: "опубликовано", draft: "черновик" }
        .to raise_error Statusable::StatusDefinedError
    end
  end
end