class Chef
  class Knife
    class Ec2Cook < Knife

      deps do
        require 'aws-sdk'
        require 'open3'
      end

      banner "knife ec2 cook (options)"
      attr_accessor :initial_sleep_delay
      attr_reader :server

      option :app,
        :short => "-a APP",
        :long => "--app app",
        :description => "Application to cook",
        :proc => Proc.new { |i| Chef::Config[:knife][:app] = i }

      option :env,
        :short => "-e ENVIRONMENT",
        :long => "--env ENVIRONMENT",
        :description => "Environment tag",
        :proc => Proc.new { |i| Chef::Config[:knife][:env] = i }

      option :user,
        :short => "-u user",
        :long => "--user USER",
        :description => "User to connect as",
        :proc => Proc.new { |i| Chef::Config[:knife][:ec2_user] = i }

      def run
        $stdout.sync = true

        access_key = config[:access_key] ||= ENV['AWS_ACCESS_KEY_ID']
        secret_key = config[:secret_key] ||= ENV['AWS_SECRET_ACCESS_KEY']

        # assumes ubuntu on ec2
        ec2_user   = config[:user] ||= "ubuntu"

        ec2 = AWS::EC2.new(:access_key_id => access_key, :secret_access_key => secret_key)
        ec2.instances.tagged_values(config[:app]).tagged_values(config[:env]).each do |i|
          cmd = "knife solo cook #{ec2_user}@#{i.private_ip_address} ~/.chef/nodes/#{config[:env]}/#{config[:app]}.json -E #{config[:env]}"
	  puts cmd
          Open3.pipeline_r(cmd) {|last_stdout, wait_threads|
            last_stdout.each_line {|line|
              puts line
            }
          }
        end
      end
    end
  end
end
