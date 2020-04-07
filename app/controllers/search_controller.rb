class SearchController < ApplicationController
  def search
	  	@model = params["search"]["model"]
	  	@content = params["search"]["content"]
	  	@how = params["search"]["how"]
	  	@datas = search_for(@how, @model, @content)
 end

  private
  def match(model, content)
  	if model == 'user'
  		@users = User.where(name: content)
  	elsif model == 'book'
  		@books = Book.where(title: content)
  	end
  end

  #前方一致→モデル名.where("カラム名 LIKE ?", "値%")
  def forward(model, content)
  	if model == 'user'
  		@users = User.where("name LIKE ?", "#{content}%")
  	elsif model == 'book'
  		@books = Book.where("title LIKE ?", "#{content}%")
  	end
  end

  #後方一致→モデル名.where("カラム名 LIKE ?", "%値" )
  def backward(model, content)
 	if model == 'user'
 		@users = User.where("name LIKE ?", "%#{content}")
 	elsif model == 'book'
 		@books = Book.where("title LIKE ?", "%#{content}")

 	end
  end

 #部分一致→モデル名,where("カラム名 LIKE ?", "%値%")
  def partial(model, content)
 	if model == 'user'
 		@users = User.where("name LIKE ?", "%#{content}%")
 	elsif model == 'book'
 		@books = Book.where("title LIKE ?", "%#{content}%")
 	end
  end

  def search_for(how, model, content)
 	case how
 	when 'match'
 		match(model, content)
 	when 'forward'
 		forward(model,content)
	when 'backward'
		backward(model, content)
	when 'partial'
		partial(model, content)
	end
  end

end
