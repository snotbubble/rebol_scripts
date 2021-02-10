REBOL [
	Title: makememyindex
]

;; made to fight an isp's sketchy automatic index.php and redirect to a cleaner site.

site: "sitename.com"
user: "username"
newsite: "newsiteurl"

h: {<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="refresh" content="0; URL='[newsite]'" />
	</head>
</html>}
h: replace h "[newsite]" newsite

i: %index.html
write i h

either exists? (to-file rejoin ["http://www." site "/index.php"]) [
	pass: ask "password: "
	either pass <> none and pass <> "" [
		write/binary join ["ftp://" user ":" pass "@ftp." site "/index.html"] read/binary i
		delete join ["ftp://" user ":" pass "@ftp." site "/index.php"]
	] [ print "invalid password" ]
] [ print "we're not fighting anybody today..." ]
