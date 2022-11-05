# README
Author: Bill Grow [bill.j.grow@gmail.com]

Date: Nov. 4, 2022

Description: This is a sample application for Red Canary's Engineering Interview Homework.  This tool is intended to be a framework for creating endpoint activity on a host machine and generating logs for the executed activity. 

## Requirements
* Ruby (Built with 3.1.2)
* SQLite3

## Installation
This is a standard rails app and can be installed with the following commands:

```
git clone 'https://github.com/bill-red-canary/red_canary_endpoint_activity_framework.git'
cd red_canary_endpoint_activity_framework
gem install bundler
bundle install
rails db:create
rails db:migrate
```

## Usage
At this time, the app is intended to be run from the command line.  The following commands are available:

```
# View available rake tasks:
rake -T | grep red_canary

rake red_canary:create_file[file_path]                  # Creates a file in the specified path
rake red_canary:create_network_connection[url,data]     # Creates a network connection with the specified url and data
rake red_canary:create_process[command]                 # Creates a process with the specified command
rake red_canary:delete_file[file_path]                  # Deletes a file in the specified path
rake red_canary:export_log[format,start_time,end_time]  # Exports the log data in the specified format
rake red_canary:run_tests                               # Runs a series of tests on the host machine
rake red_canary:update_file[file_path]                  # Updates a file in the specified path

Examples:

# Create a process on host machine
rake red_canary:create_process['cat /proc/cpuinfo']

# Create a network connection on host machine
rake red_canary:create_network_connection['https://redcanary.com',"{foo: 'bar'}"]

# Export log data in JSON format
rake red_canary:export_log | tee log.json
```

You can also run commands directly from the console or in code:
```
rails c

>>  EndpointProcess.create(command: 'ls ~')
>>  FileActivity.create(file_path: 'test.txt', action: :create)
>>  NetworkActivity.create(url: 'https://redcanary.com', data: '{"test": "data"}')
>>  RedCanary::ExportLog.new.call
```

## Tests

Tests can be run with the following command:
```
rspec
```

## Notes
* Currently the app is built with Linux and Mac commands.  Ideally locales would be configured for each platform; piping in the correct CLI equivalent string, when the command is executed by `RedCanary::ExecuteProcess`.
* Adding additional Activity Types is possible by adding a new `XyzActivity` model and `ExecuteXyzActivity` service in the established pattern. (Registry key/value modification is similar to FileActivity modification)`
* Additional `RedCanary::ExportLog` formats can be added as needed.
* Currently the app is only configured to run from the command line, but an API layer could easily be added to remotely execute activities from a webhook and return the JSON logfile.
