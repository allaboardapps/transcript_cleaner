require "fileutils"
require "pry"

source_file_name = "carlin_a_carnegie_52316.txt"
source_dir = "source"
source_path = "#{source_dir}/#{source_file_name}"

staging_dir = "staging"
staging_path = "#{staging_dir}/#{source_file_name}"

processed_dir = "processed"
processed_path = "#{processed_dir}/#{source_file_name}"

completed_dir = "completed"
completed_path = "#{completed_dir}/#{source_file_name}"

# Copy the source file to staging
FileUtils.cp(source_path, staging_path)

# Open the staging file
staging_file = File.open(staging_path, "r")

# Create the processed file
processed_file = File.new(processed_path, "w")

# Iterate through the staging file, print to processed file
line_number = 1
blank_counter = 1
while (line = staging_file.gets)
  line = line.encode("UTF-8", invalid: :replace, undef: :replace)
  line.strip!

  if line =~ /^\d:/ || line =~ /^\d\d:/ || line =~ /^\s*$/
    if blank_counter == 1
      processed_file << "\n"
    else
      processed_file << ""
    end
    blank_counter += 1
  else
    processed_file << "#{line}\n"
    blank_counter = 1
  end

  line_number += 1
  puts "#{line_number}: #{line}"
end

# Close and save processed file
processed_file.close

# Close and delete staging file
staging_file.close
FileUtils.remove(staging_file)

# Move source file to completed directory
FileUtils.mv(source_path, completed_path)

# Temporarily move completed file back to source
FileUtils.mv(completed_path, source_path)
