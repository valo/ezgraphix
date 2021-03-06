#using rspec 1.1.11
require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + '/../lib/ezgraphix'
require File.dirname(__FILE__) + '/../lib/ezgraphix/ezgraphix_helper'

include EzgraphixHelper
include Ezgraphix

describe Graphic do
  
  before do
    @g = Graphic.new
  end
    
  it do
    @g.should be_an_instance_of(Graphic)
  end
  
  it do
    @g.should have(4).defaults
  end
  
  it "should have right defaults" do
    @g.defaults.values_at(:c_type, :w, :h, :div_name).should == ['col3d', 300, 300, 'ez_graphic']
  end
  
  before do
    @g = Graphic.new(:c_type => 'bar2d', :w => 200, :caption => 'ezgraphix spec')
  end
  
  it "should merge defaults and options" do
    @g.render_options.values_at(:c_type, :w, :h, :div_name, :caption).should == ['bar2d', 200, 300, 'ez_graphic', 'ezgraphix spec']
  end
  
  it "should have chart type, width, height and div_name" do
    @g.c_type.should == 'bar2d'
    @g.w.should == 200
    @g.h.should == 300
    @g.div_name.should == 'ez_graphic'
  end  
  
  it "should have colors"  do
    Graphic::COLORS.should_not be_empty
  end
  
  it "should have valid colors" do
    @g.rand_color.should be_instance_of(String)
    @g.rand_color.length.should == 6
  end
  
  before do
    @g.data = {:ruby => 1, :perl => 2, :smalltalk => 3}
  end
  
  it "should have valid data" do
    @g.data.values_at(:ruby, :perl, :smalltalk).should == [1,2,3]
  end
  
  before do
    @g.render_options(:y_name => 'score')
  end
  
  it "should update render options" do
     @g.render_options.values_at(:c_type, :w, :h, :div_name, :caption, :y_name).should == ['bar2d', 200, 300, 'ez_graphic', 'ezgraphix spec', 'score']
  end
  
  it "should parse render options" do
    parsed = parse_options(@g.render_options)
    parsed.values_at('caption', 'yAxisName').should == ['ezgraphix spec', 'score']
  end
  
  it "should have original filename/location" do
    f_type(@g.c_type).should == '/FusionCharts/FCF_Bar2D.swf'
  end
  
  it "should have style" do
    get_style(@g).should == 'render_simple'
  end
  
  it "should have valid data when specified in the constructor" do
    g = Graphic.new(:data => {:ruby => 1, :perl => 2, :smalltalk => 3})
    g.data.values_at(:ruby, :perl, :smalltalk).should == [1,2,3]
  end
  
  it "should not show random colors if specified so" do
    g = Graphic.new(:color => "FFFF00")
    g.color.should == "FFFF00"
  end
  
  it "should render the right subcaption text" do
    g = Graphic.new(:subcaption => "This is a test")
    g.to_s.should match(/subCaption='This is a test'/)
  end
  
  it "should set the link and the hover texts" do
    g = Graphic.new
    g.data = {
               "Google" => {
                 :value => 1, :link => "http://google.com", :hoverText => "Click to go to google"
               },
               "Hotmail" => {
                 :value => 2, :link => "http://hotmail.com", :hoverText => "Click to go to hotmail"
               }
             }
    g.to_s.should match(%r{link='http://google.com'})
    g.to_s.should match(%r{link='http://hotmail.com'})
    g.to_s.should match(%r{hoverText='Click to go to google'})
    g.to_s.should match(%r{hoverText='Click to go to hotmail'})
  end
  
end
