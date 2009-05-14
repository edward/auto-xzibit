require 'rubygems'
require 'RMagick'
require 'sinatra'

get '/' do
  # haml :index
  dawg = Magick::ImageList.new("yodawg-dolls-700.jpg")
  text = Magick::Draw.new
  text.annotate(dawg, 0, 0, 0, 60, "Yo Dawg!") {
    self.gravity = Magick::SouthGravity
    self.pointsize = 48
    self.stroke = 'transparent'
    self.fill = '#0000A9'
    self.font_weight = Magick::BoldWeight
  }
  dawg.write('tmp/sup-dawg.jpg')
  
  
  send_file 'tmp/sup-dawg.jpg', :type => 'image/jpeg', :disposition => 'inline'
end

__END__

@@ layout
%html
  = yield

@@ index
%div.title Yo Dawg.