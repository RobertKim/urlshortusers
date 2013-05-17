enable 'sessions'

get '/' do
  @short_urls = Url.where(:user_id => nil)
  erb :index
end

post '/url' do
  p session
  @url = Url.find_or_create_by_url(:url => params[:url])
  # if session[:user_id]
  @url[:user_id] = session[:user_id]
  @url.save
  # end

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
  session[:user_id] = @user.id

  @short_urls = Url.where(:user_id => @user.id)

  redirect "/profile" 
end

get '/profile' do
  if current_user
    @short_urls = Url.where(:user_id => session[:user_id])
  # raise @short_urls.inspect
  # p session
    erb :profile
  else
    redirect "/"
  end
end

post '/login' do
  @user = User.find_by_email(params[:email])
  if @user.password == params[:password]
    session[:user_id] = @user.id
    redirect "/profile"
  else
    redirect "/"
  end

end

get '/logout' do

  session[:user_id] = nil
  redirect '/'

end

