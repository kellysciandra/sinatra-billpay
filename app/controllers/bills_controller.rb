class BillsController < ApplicationController

  get '/bills' do
    if !logged_in?
      redirect to '/'
    else
      @user = current_user
      @bills = current_user.bills
      erb :'/bills/index'
    end
  end

  get '/bills/user/:user_id' do
    if !logged_in?
      redirect to '/'
    else
      @user = User.find(params[:user_id])
        if @user == current_user
          @bills = current_user.bills
          erb :'/bills/index'
        else
          @bills = Bill.all
          erb :'/bills/index'
        end
    end
  end

  get '/bills/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/bills/new'
    end
  end

  post '/bills' do
    @bill = Bill.create(name: params[:name], due_date: params[:due_date], payment: params[:payment])
    @bill.user = current_user
    @bill.type = Type.create(category: params[:type][:category])
    if @bill.save
      redirect to "/bills"
    else
      flash[:message] = "Please complete due date, payment, and bill name."
      redirect to "/bills/new"
    end
  end

  get '/bills/:id' do
    if !logged_in?
      redirect to '/login'
    else
      @bill = Bill.find(params[:id])
      erb :'bills/show'
    end
  end

  get '/bills/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      @bill = Bill.find(params[:id])
      if @bill.user_id == session[:user_id]
        erb :'/bills/edit'
      else
        redirect to '/bills'
      end
    end
  end

  post '/bills/:id' do
  @bill = Bill.find(params[:id])
  @bill.update(name: params[:name], due_date: params[:due_date], payment: params[:payment])
  @bill.type.update(category: params[:type][:category])
  if @bill.save
    redirect to "/bills/#{@bill.id}"
  else
    redirect to "/bills/#{@bill.id}/edit"
  end
end

post'/bills/:id/delete' do
  if !logged_in?
    redirect to '/login'
  else
    @bill = Bill.find(params[:id])
    if current_user.id == @bill.user_id
      @bill.delete
      redirect to '/bills'
    else
      redirect to "/bills"
    end
  end
end



end
