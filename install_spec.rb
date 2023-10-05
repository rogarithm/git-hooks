require_relative './install'

describe "Installer", "operations" do

  before(:each) do
    @installer=Installer.new
    @source_full_path='~/tools/git-hooks/pre_push/bin/is_remote_updated'
    @trigger_point='pre-push'
    @install_root='/tmp/test_install_git_hook'
    @where_to_install='/tmp/test_install_git_hook/.git/hooks/pre-push'
  end

  after(:each) do
    @installer.uninstall_hook(@install_root, @trigger_point)
  end

  it "훅을 설치할 저장소 경로와 발동 조건으로 훅 설치 위치를 계산할 수 있다" do
    @installer.find_install_location(@install_root, @trigger_point).should == File.expand_path(@where_to_install)
  end
  it "훅 발동 조건으로 훅 소스 위치를 계산할 수 있다" do
    @installer.find_hook_location(@trigger_point).should == File.expand_path(@source_full_path)
  end
  it "훅을 설치할 위치와 발동 조건을 입력하면 훅을 설치한다" do
    @installer.install_hook(@trigger_point, @install_root)
    File.symlink?(@where_to_install).should == true
  end
end
