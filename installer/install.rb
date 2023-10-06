class Installer

  def initialize(install_list_path='./install_list')
    @install_list = install_list_path
    @source_root = '~/tools/git-hooks/'
  end

  def prepare_paths_to_install
    wheres = []
    File.open(@install_list, "r") do |f|
      f.each_line do |line|
        wheres.push(line.gsub(/\n/, ''))
      end
    end
    wheres
  end

  def find_hook_location(trigger_point)
    right_upper=File.join(File.expand_path(@source_root), trigger_point.sub(/-/, '_'), 'bin')
    file=`ls #{right_upper}`.sub(/\n/, '')
    "#{right_upper}/#{file}"
  end

  def find_install_location(trigger_point, where)
    File.join(File.expand_path(where), '.git/hooks', trigger_point)
  end

  def install_hook(trigger_point, *targets)
    targets.each do |target|
      if (File.symlink?(target) == false)
        File.symlink(
          find_hook_location(trigger_point),
          find_install_location(trigger_point, target)
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

  def find_install_locations(trigger_point, *wheres)
    locations = []
    wheres.each do |where|
      locations.push(File.join(
        File.expand_path(where), '.git/hooks', trigger_point))
    end
    locations
  end
end
