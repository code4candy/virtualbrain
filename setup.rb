require 'bundler/setup'
require 'sqlite3'
require 'lotus/model'
require 'lotus/model/adapters/sql_adapter'

CONNECTION_URI = "sqlite://#{ __dir__ }/test.db"

database = Sequel.connect(CONNECTION_URI)  #übersetzt ruby in SQL

database.create_table! :tasks do	
  primary_key :id
  String  :name
  Integer :user_id #Fremdschlüssel auf User-Tabelle
end

#legt diese Spalten in der Datenbank an
database.create_table! :users do	
  primary_key :id
  String :email
  String :password
end






