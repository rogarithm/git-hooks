class Installer

  def initialize
    @source_root = '~/tools/git-hooks/'
  end

  def prepare_paths_to_install(install_path_list)
    wheres = []
    File.open(install_path_list, "r") do |f|
      f.each_line do |line|
        wheres.push(
          [line.split(',')[0].strip, line.split(',')[1].strip]
        )
      end
    end
    wheres
  end

  def find_hook_location(trigger_point)
    hook_dir=File.join(
      File.expand_path(@source_root),
      trigger_point.sub(/-/, '_'),
      'bin'
    )
    hook_file=`ls #{hook_dir}`.sub(/\n/, '')
    "#{hook_dir}/#{hook_file}"
  end

  def make_install_infos(target_infos)
    install_infos = []
    target_infos.each do |target_info|
      where = target_info[0]
      trigger_point = target_info[1]
      install_infos.push(
        [find_target_location(where, trigger_point),
         trigger_point]
      )
    end
    install_infos
  end

  def find_target_location(where, trigger_point)
    File.join(
      File.expand_path(where),
      '.git/hooks',
      trigger_point
    )
  end

  def install_hook(install_infos)
    install_infos.each do |install_info|
      expanded_target = install_info[0]
      trigger_point = install_info[1]
      if (File.symlink?(expanded_target) == false)
        File.symlink(
          find_hook_location(trigger_point),
          expanded_target
        )
      end
    end
  end

  def uninstall_hook(uninstall_infos)
    uninstall_infos.each do |uninstall_info|
      expanded_target = uninstall_info[0]
      if (File.symlink?(expanded_target))
        File.delete(expanded_target)
      end
    end
  end

  def check_hooks_installed(install_path_list)
    install_infos = make_install_infos(
      prepare_paths_to_install(install_path_list)
    )
    install_infos.each do |install_info|
      expanded_target = install_info[0]
      trigger_point = install_info[1]
      if (File.symlink?(expanded_target))
        puts "#{trigger_point} hook installed on #{expanded_target}"
        puts `ls -al #{expanded_target}`
      else
        puts "#{trigger_point} hook not installed on #{expanded_target}"
      end
    end
  end

  private :find_target_location
end
