enable :sessions
get '/' do
  if session[:user_id]
    @users = User.all
    erb :index
  else
    redirect '/sessions/new'
  end
end

#----------- SESSIONS -----------

get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  @user = User.find_by email: params[:email]
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect '/'
  else
    redirect '/sessions/new'
  end
end

delete '/sessions/logout' do
  session.clear
end

#----------- USERS -----------

get '/users/new' do
  erb :sign_up
end

post '/users' do
  p params
  @user = User.create(params[:user])
  session[:user_id] = @user.id
  redirect '/'
  
end
