# encoding: utf-8

# in sqlite
# rm database.sqlite ; sequel -m migrations/ sqlite://discover.sqlite --trace


# in mysql
#sequel -m db/migrations mysql://root:password@localhost/databasename



#class CreateScheme < Sequel::Migration
Sequel.migration do
  
    up do

        create_table(:users) do
            primary_key :id
            String :email, :unique => true
            DateTime :token_valid_until
            FalseClass :is_admin, :default => false
            DateTime :created_at, :default => DateTime.now
            DateTime :updated_at, :default => DateTime.now
        end


        users = DB[:users]

        users.insert(:email => 'jmg', :created_at => DateTime.now, :updated_at => DateTime.now)
        users.insert(:email => 'stbnrivas', :created_at => DateTime.now, :updated_at => DateTime.now)

    end 




    
    down do
      # to undo of migration down can do
      #sequel -m db/migrations -M 0 mysql://root:password@localhost/databasename

      drop_table(:users)

    end
    
end
