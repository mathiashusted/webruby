require 'socket'

if File.exists? 'config.rb'
	require_relative 'config'
else
	raise "config.rb does not exist!"
end

if Log == nil
	Log = "log.txt"
end

File.write Log, "Started at #{Time.now}"

def render(file, client)
	unless Private_Files.include? file
		client.print File.new(file, "r").read
	end
end

def start_server(port)
	puts "Starting server on port #{port}..."
	server = TCPServer.new Host[:hostname], port
	puts "Configuring server..."
	if Templates[:default] == nil
		Templates[:default] = "index.html"
		File.write Log, "No default site specified, assuming index.html"
	end

	puts "Server running!"
	while client = server.accept
		client.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
		request = client.gets
		filename = request.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '').chomp
		if filename == ""
			filename = Templates[:default]
		end
		unless Templates_Dir == nil
			filename = Templates_Dir + filename
		end
		if File.exists? filename
			render filename, client
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
		start.join
	else
		puts "Could not find action #{ARGV[0]}. Did you misspell it?"
	end
else
	puts "You didn't specify an action!"
end
