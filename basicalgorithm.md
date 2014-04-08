##Basic Algorithm For "checking out" a level

-User adds level to their associations
	- Level contains names of all associated tables
	- Postgres combines table names and User's id to spin up copies of the tables
	
-User makes query in REPL
	- query is sent to the "user_levels" controller
	- user_levels controller concats the user_id and table_name to get the user table's id
	- user_levels controller queries against the temporary, per user tables
		- result comes back from DB
		- result is tested against expected result
			-if result does not match, transaction is rolled back
				-user is notified of failure
			-if result matches, transaction is committed
				-user is notified of success
				-user is moved to next stage

