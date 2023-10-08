require_relative '../install'

describe "Installer", "operations" do

  before(:each) do
    @installer=Installer.new
    @trigger_point='pre-push'
    @install_root_dir='/tmp/test_install_git_hook'
    @install_root_dir2='/tmp/test_install_git_hook2'
    @install_path_list='./install_list'
    @install_paths=[@install_root_dir, @install_root_dir2]
    @install_full_dir='/tmp/test_install_git_hook/.git/hooks/pre-push'
    @install_full_dir2='/tmp/test_install_git_hook2/.git/hooks/pre-push'
  end

  after(:each) do
    @installer.uninstall_hook(@trigger_point, @install_root_dir, @install_root_dir2)
  end

  it "훅을 설치할 저장소 경로와 발동 조건으로 훅 설치 위치를 계산할 수 있다" do
    @installer.find_install_location(@trigger_point, @install_root_dir).should == File.expand_path(@install_full_dir)
  end
  it "훅 발동 조건으로 훅 소스 위치를 계산할 수 있다" do
    @installer.find_hook_location(@trigger_point).should == File.expand_path('~/tools/git-hooks/pre_push/bin/is_remote_updated')
  end
  it "훅을 설치할 위치와 발동 조건을 입력하면 훅을 설치한다" do
    @installer.install_hook(@trigger_point, @installer.find_install_location(@trigger_point, @install_root_dir))
    File.symlink?(@install_full_dir).should == true
  end

  it "훅을 설치할 여러 저장소 경로와 발동 조건으로 저장소별 훅 설치 위치를 계산할 수 있다" do
    @installer.find_install_locations(@trigger_point, @install_paths).should == [File.expand_path(@install_full_dir), File.expand_path(@install_full_dir2)]
  end
  it "한 번에 두 곳에 훅을 설치할 수 있다" do
    @installer.install_hook(@trigger_point, [@installer.find_install_location(@trigger_point, @install_root_dir), @installer.find_install_location(@trigger_point, @install_root_dir2)])
    File.symlink?(@install_full_dir).should == true
    File.symlink?(@install_full_dir2).should == true
  end

  it "훅을 설치할 경로 정보를 파일에서 읽어올 수 있다" do
    wheres = @installer.prepare_paths_to_install
    wheres.should == [@install_root_dir, @install_root_dir2]
  end
end
