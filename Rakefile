task :bvt => :testenv do
     system "ruby tests/bvt.rb"
end

task :build do
  puts "Build docker images etc"
  sh "bundle update"
  sh "docker-compose build"
end

task :testenv => :build do
  puts "Start containers for testing"
  sh "./dashboard up"
end

task :teardown => :bvt do
  puts "Stop containers "
  sh "./dashboard down"
end

task :default => :teardown do
  puts "Build and Test"
end

task :travis do
  ["rspec spec"].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end
