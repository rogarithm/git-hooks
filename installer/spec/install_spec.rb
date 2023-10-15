require_relative '../install'

describe "Installer", "operations" do

  before(:each) do
    @installer=Installer.new
    @trigger_point='pre-push'
    @install_full_dir='/tmp/test_install_git_hook/.git/hooks/pre-push'
    @install_full_dir2='/tmp/test_install_git_hook2/.git/hooks/pre-push'
  end

  after(:each) do
    @installer.uninstall_hook(
      @installer.make_install_infos(
        @installer.prepare_paths_to_install('./spec/data/install_list')
      )
    )
  end

  it "설정 파일 내용으로부터 훅을 설치하는 데 필요한 정보를 계산할 수 있다" do
    @installer.make_install_infos(
      @installer.prepare_paths_to_install('./spec/data/install_list2')
    ).should == [[File.expand_path(@install_full_dir), @trigger_point]]
  end
  it "훅 발동 조건으로 훅 소스 위치를 계산할 수 있다" do
    @installer.find_hook_location(
      @trigger_point
    ).should == File.expand_path('~/tools/git-hooks/pre_push/bin/is_remote_updated')
  end
  it "훅을 설치할 위치와 발동 조건을 입력하면 훅을 설치한다" do
    @installer.install_hook(
      @installer.make_install_infos(
        @installer.prepare_paths_to_install('./spec/data/install_list2')
      )
    )
    File.symlink?(@install_full_dir).should == true
  end

  it "설정 파일 내용으로부터 여러 개의 훅을 설치하는 데 필요한 정보를 계산할 수 있다" do
    @installer.make_install_infos(
      @installer.prepare_paths_to_install('./spec/data/install_list')
    ).should ==
    [
      [File.expand_path(@install_full_dir), @trigger_point],
      [File.expand_path(@install_full_dir2), @trigger_point]
    ]
  end
  it "한 번에 두 곳에 훅을 설치할 수 있다" do
    @installer.install_hook(
      @installer.make_install_infos(
        @installer.prepare_paths_to_install('./spec/data/install_list')
      )
    )
    File.symlink?(@install_full_dir).should == true
    File.symlink?(@install_full_dir2).should == true
  end

  it "훅을 설치할 경로와 발동 조건 정보를 파일에서 읽어올 수 있다" do
    @installer.prepare_paths_to_install('./spec/data/install_list').should == [['/tmp/test_install_git_hook', @trigger_point], ['/tmp/test_install_git_hook2', @trigger_point]]
  end

  it "훅이 설치되었는지 확인할 수 있다" do
    @installer.check_hooks_installed('./spec/data/install_list')
  end
end
