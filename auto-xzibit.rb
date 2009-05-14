require 'rubygems'
require 'RMagick'
require 'sinatra'

def annotate_dawg(message, colour = '#000000')
  dawg = Magick::ImageList.new("yodawg-dolls-700.jpg")
  text = Magick::Draw.new
  text.annotate(dawg, 0, 0, 0, 60, message) {
    self.gravity = Magick::SouthGravity
    self.pointsize = 48
    self.stroke = 'transparent'
    self.fill = colour
    self.font_weight = Magick::BoldWeight
  }
  dawg.write('tmp/sup-dawg.jpg')
  
end

get '/' do
  annotate_dawg("dawg?")
  haml :index
  
  # send_file 'tmp/sup-dawg.jpg', :type => 'image/jpeg', :disposition => 'inline'
end

post '/' do
  annotate_dawg(params[:message])
  redirect '/'
end

get '/sup-dawg.jpg' do
  annotate_dawg(params[:message])
  send_file 'tmp/sup-dawg.jpg', :type => 'image/jpeg', :disposition => 'inline'
end

__END__

@@ layout
!!!
%html
  = yield

@@ index
%img{:src => "sup-dawg.jpg?message=#{params[:message] || 'Sup dawg?'}"}

%form{:action => '/'}
  %input{:type => 'text', :name => 'message', :value => 'Say whaaa?'}
  %input{:type => 'submit', :value => 'Boomshakala. Do it.'}