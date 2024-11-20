# frozen_string_literal: true

namespace :dreambook do
  desc 'Import dream patterns from file'
  task import: :environment do
    file_path = Rails.root.join('tmp/import/dream_patterns.yml').to_s
    if File.exist? file_path
      puts 'Importing dream patterns...'
      File.open file_path, 'r' do |file|
        YAML.safe_load(file).each do |name, data|
          next if data['description'].blank? || data['summary'].blank?

          pattern = DreamPattern.find_or_initialize_by(name:)

          attributes = {
            description: data['description'],
            summary: data['summary']
          }

          pattern.assign_attributes attributes
          pattern.save!
          print "\r#{name}    "
        end
        puts
      end
      puts "Done. We have #{DreamPattern.count} dream patterns now."
    else
      puts "Cannot find file #{file_path}"
    end
  end
end
