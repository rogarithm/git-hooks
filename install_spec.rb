require_relative './install'

describe "Installer", "operations" do
  before(:each) do
    @installer=Installer.new
  end

  it "훅을 설치할 저장소 경로와 발동 조건으로 훅 설치 위치를 계산할 수 있다" do
    @installer.install_location('/tmp/test_install_git_hook', 'pre-push').should == File.expand_path('/tmp/test_install_git_hook/.git/hooks/pre-push')
  end
  it "훅 발동 조건으로 훅 소스 위치를 계산할 수 있다" do
    @installer.hook_location('pre-push').should == File.expand_path('~/tools/git-hooks/pre_push/bin/is_remote_updated')
  end
  it "훅을 설치할 위치와 발동 조건을 입력하면 훅을 설치한다" do
    @installer.install_hook('pre-push', '/tmp/test_install_git_hook')
    File.symlink?('/tmp/test_install_git_hook/.git/hooks/pre-push').should == true
  end
end
