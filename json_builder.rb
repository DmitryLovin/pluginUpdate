require 'json'

# Get the list of JSON files in the "raw" folder
json_files = Dir.glob('raw/*.json')

# Function to join arrays with '\n'
def join_arrays_with_newline(data)
  data.each do |key, value|
    if value.is_a?(Array)
      data[key] = value.join("\n")
    elsif value.is_a?(Hash)
      join_arrays_with_newline(value)
    end
  end
end

# Process each JSON file
json_files.each do |json_file|
  # Read the JSON file
  file = File.read(json_file)
  data = JSON.parse(file)

  # Modify the JSON data
  join_arrays_with_newline(data)

  # Get the filename without the "raw/" folder
  filename = File.basename(json_file)

  # Construct the path for the modified file in the root folder
  modified_path = "#{filename}"

  # Write the modified data to the new file in the root folder
  File.write(modified_path, JSON.pretty_generate(data))

  puts "Modified JSON file saved: #{modified_path}"
end
