require 'rubygems'
require 'RMagick'
require 'sinatra'

def annotate_dawg(message)
  dawg = Magick::ImageList.new("yodawg-dolls-700.jpg")
  text = Magick::Draw.new
  text.annotate(dawg, 0, 0, 0, 60, message) {
    self.gravity = Magick::SouthGravity
    self.pointsize = 48
    self.stroke = 'transparent'
    self.fill = '#000000'
    self.font_weight = Magick::BoldWeight
  }
  dawg.write('tmp/sup-dawg.jpg')
end

get '/' do
  haml :index
  
  # send_file 'tmp/sup-dawg.jpg', :type => 'image/jpeg', :disposition => 'inline'
end

post '/' do
  annotate_dawg(params[:message])
  redirect '/'
end

__END__

@@ layout
%html
  = yield

@@ index
  %p Yo Dawg.
  %img{:src => 'tmp/sup-dawg.jpg'}

  %form{:action => '/', :method => 'post'}
    %input{:type => 'text', :name => 'message', :value => 'Your new message goes here.'}
    %input{:type => 'submit', :value => 'Boomshakala. Do it.'}