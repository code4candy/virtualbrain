require 'bundler/setup'
require 'sqlite3'
require 'lotus/model'
require 'lotus/model/adapters/sql_adapter'

CONNECTION_URI = "sqlite://#{ __dir__ }/test.db"

database = Sequel.connect(connection_uri)  #übersetzt ruby in SQL

database.create_table! :tasks do
  primary_key :id
  String  :name
end

# create table 'tasks' (id)
