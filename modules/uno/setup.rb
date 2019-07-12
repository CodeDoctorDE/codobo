# frozen_string_literal: true

require_relative './uno-module.rb'
class UnoModule
  def setup
    puts 'Setup up uno module...'
    @client.query("CREATE TABLE IF NOT EXISTS `uno` (
      `SERVERID` int(50) unsigned NOT NULL,
      `THEME` varchar(255) NOT NULL,
      `MESSAGE` int(50) NOT NULL,
      `CATEGORY` int(50) NOT NULL,
      PRIMARY KEY  (`SERVERID`)
    );")
    puts 'Successfully set up uno module ...'
  end
end
