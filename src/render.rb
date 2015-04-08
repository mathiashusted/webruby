
def render(filename, client)
	#Open file from filename
	file = File.new(filename, "r")
	unless Private_Files.include? filename
		client.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
		if Ruby_Mode == true
			client.print eval file.read
		else
			client.print file.read
		end
	end
end