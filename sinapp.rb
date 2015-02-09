require "rubygems"  
require "sinatra"  
# if use active record
require "active_record"  
require "mysql2"

#if use sequel
require "sequel"
require "mysql"

require "nokogiri"

require "json"
  
configure do  
  ActiveRecord::Base.establish_connection(  
    :adapter  => "mysql2",  
    :host     => "127.0.0.1",  
    :username => "stbn",  
    :password => "software",  
    :database => "AQLT"  
  )  
end  

=begin
configure do  
  ActiveRecord::Base.establish_connection(  
    :adapter  => "mysql2",  
    :host     => "192.168.1.133",  
    :username => "jmgalaminos",  
    :password => "System2406",  
    :database => "AQLT"  
  )  
end 
=end



#DB = Sequel.connect('mysql://AQLT:jmgalaminos@192.168.1.133/users')



#Sequel::Model.plugin(:schema)  # I worked this out, but I can't find it documented
DB = Sequel.connect('mysql://stbn:software@localhost/AQLT',:logger => Logger.new('db.log'))

#sequel = Sequel.connect('mysql://root:root@localhost/ruote_test')
#sequel = Sequel.connect(
#  :adapter => 'mysql2',
#  :user => 'root',
#  :password => 'root',
#  :socket=> '/tmp/mysql.sock',
#  :database => 'foo_development')


 
class User < ActiveRecord::Base

end  


#Sequel::Model.plugin(:schema)  # I worked this out, but I can't find it documented
#DB = Sequel.connect('sqlite://db/discover.sqlite',:logger => Logger.new('db.log'))


#class Stream
#  def each
#    100.times { |i| yield "#{i}\n" }
#  end
#end

#get('/stream') { Stream.new }

get "/" do  
  
 erb :index
end 


#get "/usuarios" do  
#  content_type :json
#  foo = DB[:serverinfo].select(:DB, :SERVERNM).where(:STATUS => 'A').first
#  erb: 
 
#end 

get '/users' do
 @result = String.new
 @users = DB[:users]

  @users.each do |u|
    @result << "<hr>" << u[:id] << " " << u[:email].to_s << "<hr>"
  end

 erb :users
end





get "/user/:id" do
  @result = String.new
  @users = DB["select * from  users where id = #{params[:id]}"]
  @users.each do |u|
    @result << "<hr>" << u[:email] << "<hr>"
  end

  erb :users
end


