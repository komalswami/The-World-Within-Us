
# ROR Blog

create new rails project
```
rails new project_name
```

Start server
```
bin/rails server
```
generating controller
```
bin/rails generate controller Articles index --skip-routes
bin/rails generate controller Articles index 
```

generating model
```
bin/rails generate model Article title:string body:text
```

db migration
```
bin/rails db:migrate
```

rails console
```
bin/rails console

article
Article.find(1)
Article.all
```

Resourceful Routing
```
resources :articles
```

Associating Models
```
bin/rails generate model Comment commenter:string body:text article:references
```
* Each comment belongs to one article.
* One article can have many comments.

```
class Comment < ApplicationRecord
  	belongs_to :article
end
```

belongs_to :other model
which sets up an active record association


this will also create a special column refrences to hold the ref i.e article id 
```
class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
```

Relation:
* Each comment belongs to one article.
* One article can have many comments.

```
class Comment < ApplicationRecord
  belongs_to :article
end

class Article < ApplicationRecord
  has_many :comments
end
```
one more imp thing while adding routes
```
Rails.application.routes.draw do
  root "articles#index"

  resources :articles do
    resources :comments
  end
end
```

This will also create a special column refrences in migration / databaseto hold the ref i.e article id 
```
class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
```



```
<h1><%= @article.title %></h1>

<p><%= @article.body %></p>

<ul>
  <li><%= link_to "Edit", edit_article_path(@article) %></li>
  <li><%= link_to "Destroy", article_path(@article),
                  method: :delete,
                  data: { confirm: "Are you sure?" } %></li>
</ul>


<h2>Add a comment:</h2>

" <%= form_with model: [ @article, @article.comments.build ] do |form| %> "
  <p>
    <%= form.label :commenter %><br>
    <%= form.text_field :commenter %>
  </p>
  <p>
    <%= form.label :body %><br>
    <%= form.text_area :body %>
  </p>
  <p>
    <%= form.submit %>
  </p>
<% end %>
```

For Controller:
```
class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
```
