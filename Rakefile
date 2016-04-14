task :bvt do
     system "ruby tests/bvt.rb"
end

task :build do
  puts "Build docker images etc"
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

task :default => :bvt do
  puts "Build and Test"
end
