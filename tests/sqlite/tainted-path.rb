#!/usr/bin/ruby -w
system 'clear' unless ENV['clear_done']
require_relative '../testmin.rb'
require_relative '../testing.lib.rb'

# enable taint mode
$SAFE = 1

# set file name
db_path = 'whatever'
db_path = UtilibaseTesting.db_path(db_path)
FileUtils.rm_rf(db_path) or die $!
FileUtils.touch(db_path) or die $!

# taint path
db_path.taint

# begin
begin
	Utilibase::DBH.new(db_path)
	raise 'previous operation should have thrown exception'
rescue ExceptionPlus::Internal => e
	UtilibaseTesting.error_id 'error id', e, 'tainted-db-path'
	UtilibaseTesting.is_internal 'is internal', e
	UtilibaseTesting.internal_id 'internal id', e, 'z7gwj'
rescue ExceptionPlus => e
	raise 'should not have gotten ExceptionPlus'
rescue Exception => e
	raise 'should not have gotten plain exception'
end

# done
# puts '[done]'
Testmin.done()
