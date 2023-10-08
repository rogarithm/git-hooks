class Installer

  def initialize(install_path_list='./install_list')
    @install_path_list = install_path_list
    @source_root = '~/tools/git-hooks/'
  end

  def prepare_paths_to_install
    wheres = []
    File.open(@install_path_list, "r") do |f|
      f.each_line do |line|
        wheres.push(line.gsub(/\n/, ''))
      end
    end
    wheres
  end

  def find_hook_location(trigger_point)
    right_upper=File.join(
      File.expand_path(@source_root),
      trigger_point.sub(/-/, '_'),
      'bin'
    )
    file=`ls #{right_upper}`.sub(/\n/, '')
    "#{right_upper}/#{file}"
  end

  def find_install_locations(trigger_point, wheres)
    locations = []
    wheres.each do |where|
      locations.push(File.join(
          File.expand_path(where),
          '.git/hooks',
          trigger_point
        ))
    end
    locations
  end

  def find_install_location(trigger_point, where)
    File.join(
      File.expand_path(where),
      '.git/hooks',
      trigger_point
    )
  end

  def install_hook(trigger_point, expanded_targets)
    expanded_targets.each do |expanded_target|
      if (File.symlink?(expanded_target) == false)
        File.symlink(
          find_hook_location(trigger_point),
          expanded_target
        )
      end
    end
  end

  def uninstall_hook(trigger_point, *wheres)
    wheres.each do |where|
      where_installed=find_install_location(trigger_point, where)
      if (File.symlink?(where_installed))
        File.delete(where_installed)
      end
    end
  end

  private :find_install_location
end
