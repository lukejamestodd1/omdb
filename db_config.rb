require 'active_record'

options = {
	adapter: 'postgresql',
	database: 'moviesdatabase'

}
ActiveRecord::Base.establish_connection(options)