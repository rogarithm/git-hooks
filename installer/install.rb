class Installer

  def initialize()
    @source_root = '~/tools/git-hooks/'
  end

  def find_hook_location(trigger_point)
    right_upper=File.join(File.expand_path(@source_root), trigger_point.sub(/-/, '_'), 'bin')
    file=`ls #{right_upper}`.sub(/\n/, '')
    "#{right_upper}/#{file}"
  end

  def find_install_location(where, trigger_point)
    File.join(File.expand_path(where), '.git/hooks', trigger_point)
  end

  def install_hook(trigger_point, target)
    if (File.symlink?(target) == false)
      File.symlink(find_hook_location(trigger_point), find_install_location(target, trigger_point))
    end
  end

  def uninstall_hook(where, trigger_point)
    where_installed=find_install_location(where, trigger_point)
    if (File.symlink?(where_installed))
      File.delete(where_installed)
    end
  end

  def install_hook_to_targets(trigger_point, targets)
    targets.each do |target|
    end
  end
end
