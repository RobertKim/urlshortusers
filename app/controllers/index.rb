enable 'sessions'

get '/' do
  @short_urls = Url.where(:user_id => nil)
  erb :index
end

post '/url' do
  @url = Url.find_or_create_by_url(:url => params[:url])
  redirect "/url/#{@url.short_url}"
end

get '/url/:short_url' do
  @url = Url.find_by_short_url(params[:short_url])
  erb :url
end

post '/signup' do
  @user = User.find_or_create_by_email(name: params[:name], 
                      email: params[:email], 
                      password: params[:password])
  session[:id] = @user.id

  @short_urls = Url.where(:user_id => @user.id)
  redirect "/profile/#{@user.id}" 
end

get '/profile/:id' do
  @user = User.find(params[:id])
  @short_urls = Url.where(:user_id => @user.id)
  p session
  erb :profile

end

get '/logout' do

  session.clear
  redirect '/'

end
