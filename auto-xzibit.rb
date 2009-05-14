require 'rubygems'
require 'RMagick'
require 'sinatra'

def annotate_dawg(message, colour = '#000000')
  dawg = Magick::ImageList.new("yodawg-dolls-700.jpg")
  text = Magick::Draw.new
  text.annotate(dawg, 0, 0, 0, 60, wrap_text(message).strip) {
    self.gravity = Magick::SouthGravity
    self.pointsize = 48
    self.stroke = 'transparent'
    self.fill = colour
    self.font_weight = Magick::BoldWeight
  }
  dawg.write('tmp/sup-dawg.jpg')
end

def wrap_text(txt, col = 15)
  txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n")
end

get '/' do
  haml :index
end

get '/sup-dawg.jpg' do
  message = params[:message]
  message = 'Sup dawg?' if message.empty?
  
  annotate_dawg(message)
  send_file 'tmp/sup-dawg.jpg', :type => 'image/jpeg', :disposition => 'inline'
end

__END__

@@ layout
!!!
%html
  = yield

@@ index
%img{:src => "sup-dawg.jpg?message=#{params[:message]}&colour=#{params[:colour]}"}

%form{:action => '/'}
  %input{:type => 'text', :name => 'message', :value => "#{params[:message] || 'Say whaaa?'}"}
  %input{:type => 'submit', :value => 'Boomshakala. Do it.'}