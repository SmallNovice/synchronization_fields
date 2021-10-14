module Sequelable
  extend ActiveSupport::Concern

  def self.create_field(table_name, fields = {})
    db_connect.alter_table table_name do
      fields.each do |k|
        binding.pry
        if (InitialFieldToFormField.column_names & [k[:identity_key]]).blank?
          add_column :"#{k[:identity_key]}", String
        end
      end
    end
  end

  private

  def self.db_connect
    return @db if @db
    @db = Sequel.connect('sqlite://db/development.sqlite3')
  end
end
