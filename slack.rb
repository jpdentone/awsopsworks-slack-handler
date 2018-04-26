stack = search("aws_opsworks_stack").first

handler_file = "#{node['chef_handler']['handler_path']}/opsworks-configure.rb"

template handler_file do
  source "handlers/opsworks-configure.rb.erb"
  mode "0600"
  user "root"
  group "root"
  action :nothing
  variables ({
    nodename: stack["name"] + "-" + node[:hostname],
    :webhook => "<insert slac webhook"
  })
end.run_action(:create)

chef_handler "Chef::Handler::SlackReporting" do
  source handler_file
  action :nothing
end.run_action(:enable)