require 'spec_helper'
require 'smartargs'

class T1
  extend Smartargs::Mixin

  sub [String, Fixnum], def hoge(x, y)
    true
  end

end

describe Smartargs do

  it 'has a version number' do
    expect(Smartargs::VERSION).not_to be nil
  end

  it 'returns true' do
    t = T1.new
    expect(t.hoge("str", 100)).to eq(true)
  end

  # 型がちがう
  it 'returns ArgumentError' do
    t = T1.new
    expect { t.hoge("str", "100") }.to raise_error(ArgumentError)
  end

  # すくない
  it 'returns ArgumentError' do
    t = T1.new
    expect { t.hoge("str") }.to raise_error(ArgumentError)
  end

  # 多い
  it 'returns ArgumentError' do
    t = T1.new
    expect { t.hoge("str", 100, "fuga") }.to raise_error(ArgumentError)
  end
end
