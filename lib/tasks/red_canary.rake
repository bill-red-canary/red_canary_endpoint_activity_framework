namespace :red_canary do
  desc 'Runs a series of tests on the host machine. Tests include, Running Processes, Network Activity and File Activity.'
  task 'run_tests' => :environment do
    puts RedCanary::RunTests.new.call
  end

  desc 'Creates a file in the specified path'
  task 'create_file', [:file_path] => :environment do |_, args|
    usage = %(
      USAGE: rake red_canary:create_file[file_path]
    )
    abort(usage) unless args[:file_path]

    pp FileActivity.create(file_path: args[:file_path], activity: :create)
  end

  desc 'Updates a file in the specified path'
  task 'update_file', [:file_path] => :environment do |_, args|
    usage = %(
      USAGE: rake red_canary:update_file[file_path]
    )
    abort(usage) unless args[:file_path]

    pp FileActivity.create(file_path: args[:file_path], activity: :update)
  end

  desc 'Deletes a file in the specified path'
  task 'delete_file', [:file_path] => :environment do |_, args|
    usage = %(
      USAGE: rake red_canary:delete_file[file_path]
    )
    abort(usage) unless args[:file_path]

    pp FileActivity.create(file_path: args[:file_path], activity: :delete)
  end

  desc 'Creates a process with the specified command'
  task 'create_process', [:command] => :environment do |_, args|
    usage = %(
      USAGE: rake red_canary:create_process[command]
    )
    abort(usage) unless args[:command]

    pp EndpointProcess.create(command: args[:command])
  end

  desc 'Creates a network connection with the specified url and data'
  task 'create_network_connection', [:url, :data] => :environment do |_, args|
    usage = %(
      USAGE: rake red_canary:create_network_connection[url,data]
    )
    abort(usage) unless args[:url]

    pp NetworkActivity.create(url: args[:url], data: args[:data])
  end
end
