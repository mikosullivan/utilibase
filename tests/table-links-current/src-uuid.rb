#!/usr/bin/ruby -w
system 'clear' unless ENV['clear_done']
require_relative '../testing.lib.rb'

# enable taint mode
$SAFE = 1

# purpose: test src_uuid
#	references record in current

# reset directory
# UtilibaseTesting.reset_db_dir()

# create, initialize, instantiate database
db = UtilibaseTesting.new_db()
dbh = db.dbh

# table name
table_name = 'links_current'


#------------------------------------------------------------------------------
# structure
#
if true
	Testmin.hr 'structure'
	
	# field structure
	UtilibaseTesting.field_structure(
		dbh,           # dbh
		table_name,    # table name
		'src_uuid',    # field name
		1,             # pk
		'text',        # type
		1,             # 1 if not null, 0 if nullable
		nil)           # default
end
#
# structure
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# references record in current
#
if true
	Testmin.hr('references record in current')
	
	UtilibaseTesting.check_foreign_key(
		dbh,
		table_name,
		'current',
		'src_uuid',
		'record_uuid',
		'CASCADE'
	)
end
#
# references record in current
#------------------------------------------------------------------------------


# done
# puts '[done]'
Testmin.done()
