class Installer

  def initialize()
    @source_root = '~/tools/git-hooks/'
  end

  def install_hook(trigger_point, target)
    if (File.symlink?(target) == false)
      File.symlink(hook_location(trigger_point), install_location(target, trigger_point))
    end
  end

  def hook_location(trigger_point)
    right_upper=File.join(File.expand_path(@source_root), trigger_point.sub(/-/, '_'), 'bin')
    file=`ls #{right_upper}`.sub(/\n/, '')
    "#{right_upper}/#{file}"
  end

  def install_location(where, trigger_point)
    File.join(File.expand_path(where), '.git/hooks', trigger_point)
  end

  def uninstall_hook(where, trigger_point)
    location=install_location(where, trigger_point)
    if (File.symlink?(location))
      File.delete(location)
    end
  end
end
