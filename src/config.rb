#Hostname for the server, and the default port if no other is specified
Host = {
	:hostname => '127.0.0.1',
	:defaultport => 8000
}

#Sets the filename for the log file
Log = "log.txt"

#Files that are not accesible for a client
Private_Files = [
	"config.rb",
	"manage.rb"
]

#Sites to display in certain cases
Templates = {
	:default => "index.html",
	:error_404 => nil
}

#Default directory for the site
Templates_Dir = "views/"
