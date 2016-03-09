node['apache']['version'] = '2.4'


default["lamp"]["sites"]["example.com"] =
 { "port" => 80, 
 "servername" => "example.com", 
 "serveradmin" => "webmaster@example.com" 
 }