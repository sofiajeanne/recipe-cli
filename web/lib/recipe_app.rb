require 'rubygems'
require 'sinatra'
require 'data_mapper' # metagem, requires common plugins too.

# must install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!

get '/' do
  # get the latest 20 posts
  @posts = Post.all(:order => [ :id.desc ], :limit => 20)
  erb :index
end