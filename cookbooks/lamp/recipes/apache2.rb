package "apache2" do
version '2.4'
  action :install
end



default["apache"]["version"] = "2.4"

case platform
when "centos", "rhel"
default['apache']['version'] = "2.4"


service "apache2" do
  action [:enable, :start]
end

#Virtual Hosts Files

node["lamp"]["sites"].each do |sitename, data|
end


node["lamp"]["sites"].each do |sitename, data|
  document_root = "/var/www/html/#{sitename}"
   directory document_root do
    mode "0755"
    recursive true
  end
  
  template "/etc/httpd/sites-available/#{sitename}.conf" do
    source "virtualhosts.erb"
    mode "0644"
    variables(
      :document_root => document_root,
      :port => data["port"],
      :serveradmin => data["serveradmin"],
      :servername => data["servername"]
    )
	notifies :restart, "service[apache2]"
  end
  
   directory document_root do
    mode "0755"
    recursive true
  end

  execute "enable-sites" do
    command "a2ensite #{sitename}"
    action :nothing
  end

  template "/etc/httpd/sites-available/#{sitename}.conf" do
   notifies :run, "execute[enable-sites]"
    directory "/var/www/html/#{sitename}/public_html" do
    action :create
  end

  directory "/var/www/html/#{sitename}/logs" do
    action :create
  end
  
 
  
end