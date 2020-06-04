require 'pry'
require 'sqlite3'
require 'faker'

DB = SQLite3::Database.new('db/twitter.db')
# DB = {
#     conn: SQLite3::Database.new('db/twitter.db')
# }

DB.results_as_hash = true

require_relative '../lib/tweet'
require_relative '../db/seed'


# Create the table
Tweet.create_table
