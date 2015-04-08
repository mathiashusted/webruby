#Hostname for the server, and the default port if no other is specified
Host = {
	:hostname => '127.0.0.1',
	:defaultport => 8000
}

#Files that are not accesible for a client
Private_Files = [
	"config.rb",
	"manage.rb"
]

#Enter banned IPs as strings
#This feature has not been thoroughly tested yet
Banned_IPs = [
	
]

#Sites to display in certain cases
Templates = {
	:default => "index.html",
	:error_404 => nil,
	:banned => nil
}

#Default directory for the site
Templates_Dir = "views/"

#Set this to true to allow Ruby code in the html document
#Currently in testing phase
Ruby_Mode = false