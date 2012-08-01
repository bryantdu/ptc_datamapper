require 'rubygems'
require 'csv-mapper'
require 'active_record'
require 'sqlite3'
include CsvMapper

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "ptc_datamapper.sqlite3"
)

ActiveRecord::Schema.define do 
    create_table :people do |t|
        t.column :input_id, :string 
        t.column :first_name, :string
        t.column :last_name, :string
        t.column :address, :string
        t.column :city, :string
        t.column :state, :string
        t.column :zip, :string
        t.column :email, :string
        t.column :birth_month, :string
        t.column :birth_day, :string
        t.column :birth_year, :string
        t.column :ptc, :string
        t.column :date_created, :string
    end
end

class Mapper
    def import_data(importfile)
        @importfile = importfile
        @persons = import_from_file
    end

    def export_data(exportfile)
        @exportfile = exportfile
        export_to_file
    end

    def import_from_file
        results = import(@importfile) do
            map_to Person
#           after_row lambda{|row, person| person.save}

            start_at_row 0
            [input_id, first_name, last_name, address, city, state, zip, email, birth_month, birth_day, birth_year, ptc, date_created]
        end
        results
    end

    def get_cr_row
        'CR|6|9999000024542||9289560|CLEARBNS|||7020||||||20120530||1325|||||||||'
    end

    def format_row(data)
        row = ''
        data.each {|r| row = row.to_s + "#{r}|"}
        row = row[0..-2] 
    end

    def print_result
        @persons.each do |p|
            puts format_row(p.ptc_data)
        end
    end



    def export_to_file
        File.open(@exportfile,'w') do |export|
            export.puts get_cr_row
            @persons.each do |p|
                export.puts format_row(p.na_data)
                export.puts format_row(p.ptc_data) if p.ptc
            end
        end
    end
end


class Person < ActiveRecord::Base
    def ptc_data
        value_array = ['PTC', 6, self.input_id, '1325', '', '', 'Y','Y', '', self.date_created]
    end

    def na_data
        value_array = ['NA', 6, self.input_id, '', '', '', '', '', self.first_name, '', self.last_name, '', self.address, '', '', self.city, self.state, self.zip, '', '', '', '', '', '', '', '', self.email, '', '', '', '', self.date_created.gsub!(' ','|') ]
    end
end

importfile = ARGV[0]
exportfile = ARGV[1]
start_time = Time.now.to_f * 1000
mapper = Mapper.new
mapper.import_data(importfile)
mapper.export_data(exportfile)
end_time = Time.now.to_f * 1000
puts 'File save successfully!'
puts 'Time used:' << (end_time - start_time).to_s << 'ms'
