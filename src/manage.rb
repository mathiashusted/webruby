require 'socket'

if File.exists? 'config.rb' and File.exists? 'render.rb'
	require_relative 'config'
	require_relative 'render.rb'
else
	doesnt_exist = " does not exist! You can download it again by cloning or downloading the Git repository at http://github.com/mksas/webruby and paste it into the main folder"
	if not File.exists? 'config.rb'
		raise "config.rb #{doesnt_exist}"
	elsif not File.exists? 'render.rb'
		raise "render.rb #{doesnt_exist}"
	end
end


def start_server(port)
		if port.to_i <= 65535
			puts "Starting server on port #{port}..."
			server = TCPServer.new Host[:hostname], port
			puts "Configuring server..."
			if Templates[:default] == nil
				Templates[:default] = "index.html"
			end
		else
			raise "Your port can't be higher than 65535!"
		end

		puts "Server running! Press CTRL + C at anytime to stop"
		while client = server.accept
			request = client.gets
			sock_domain, remote_port, remote_hostname, remote_ip = client.peeraddr
			filename = request.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '').chomp
			if filename == ""
				filename = Templates[:default]
			end
			unless Templates_Dir == nil
				filename = Templates_Dir + filename
			end
			if File.exists? filename
				if not Banned_IPs.include? remote_ip
					render filename, client
				else
					if Templates[:banned] != nil
						render Templates[:banned], client
					else
						client.print "You have been banned from this website!"
					end
				end
			else
				if Templates[:error_404] != nil
					if Templates_Dir != nil
						render Templates_Dir + Templates[:error_404], client
					else
						render Templates[:error_404], client
					end
				else
					client.print "<h1>404 Not Found</h1>"
				end
			end
			client.close
		end
end

if ARGV[0] != nil
	case ARGV[0]
	when "startserver"
		if ARGV[1] == nil
			ARGV[1] = Host[:defaultport]
		end
		start = Thread.new{start_server ARGV[1]}
		begin
			start.join
		rescue SystemExit, Interrupt
			puts "\nServer stopped at #{Time.now}"
		end
	else
		puts "Could not find action #{ARGV[0]}. Did you misspell it?"
	end
else
	puts "You didn't specify an action!"
end
