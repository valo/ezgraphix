$LOAD_PATH.unshift File.dirname(__FILE__) + "/lib"
require 'ezgraphix'
ActionView::Base.send :include, Ezgraphix::EzgraphixHelper
