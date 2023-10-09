require_relative 'installer/install'

task :install do
  puts "install hooks!"
  installer = Installer.new
  installer.install_hook(
    'pre-push',
    installer.find_target_locations(
      'pre-push',
      installer.prepare_paths_to_install('./installer/install_list')
    )
  )
end

task :uninstall do
  puts "uninstall hooks!"
  installer = Installer.new
  installer.uninstall_hook(
    'pre-push',
    installer.find_target_locations(
      'pre-push',
      installer.prepare_paths_to_install('./installer/install_list')
    )
  )
end
