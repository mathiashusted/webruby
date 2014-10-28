#Hostname for the server, and the default port if no other is specified
Host = {
	:hostname => '127.0.0.1',
	:defaultport => 8000
}

#Files that are not accesible from the server
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
