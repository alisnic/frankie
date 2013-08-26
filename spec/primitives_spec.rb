require 'spec_helper'

describe Request do
  let (:subject) { Request.new double }

  it { should be_a(Rack::Request) }
end

describe Response do
  it { should be_a(Rack::Response) }

  describe '#raw_body' do
    it 'should be accesible when the response was initialized' do
      raw_body = double
      res = Response.new raw_body
      res.raw_body.should == raw_body
    end

    it 'should accesible after body was set' do
      res = Response.new
      raw_body = double
      res.body = raw_body
      res.raw_body.should == raw_body
    end

    it 'should set the iterable as the raw body as well' do
      res = Response.new
      raw_body = ['one', 'two']
      res.body = raw_body
      res.raw_body.should == raw_body
    end
  end
end
