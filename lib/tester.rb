
require 'rubygems'
require 'sqlite3'

DB = SQLite3::Database.open (File.expand_path('../recipes.sqlite', __FILE__))

=begin
Questions for James
1. should i not be using a tester? what is the normal way to do this?
2. what are good next steps for this project? maybe javascript or rails to create a browser interface?
3. run through code


- sublime - functionality to expand and contract options 
- become more comfortable with version control
- look for addtl functionality around jumping between methods, navigating the 
- use pry more instead of this tester business

- don't use rails maybe, it's very complicated
- sinatra: for putting stuff online through a browser
- read more about http/browsers, etc
- look at http libraries ruby (instead of using a full framework), perhaps write a small sinatra framework perhaps to help you understand


- do a really basic website adding javascript to practice

- separate first class into two: one for input, and one for storing (distinct functionality for parts)
- alternatively: have one part that deals with user, another that processes, adn a third that deals with the database
- business logic
- four aspects: db versus user, and storing versus getting

- do going from recipe to ingredients using one single database query: use join to eliminate ruby manipulation between data pulls (learn more about SQL)

- unit as null (1 egg, when there's no unit)
- work on pluralization 
=end