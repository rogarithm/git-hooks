require_relative 'installer/install'

task :install do
  puts "install hooks!"
  installer = Installer.new
  installer.install_hook(
    installer.make_install_infos(
      installer.prepare_paths_to_install('./installer/install_list')
    )
  )
  installer.check_hooks_installed('./installer/install_list')
end

task :uninstall do
  puts "uninstall hooks!"
  installer = Installer.new
  installer.uninstall_hook(
    installer.make_install_infos(
      installer.prepare_paths_to_install('./installer/install_list')
    )
  )
  installer.check_hooks_installed('./installer/install_list')
end
