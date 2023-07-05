# original is https://github.com/hashicorp/homebrew-tap/blob/3030e1b7a514209fbebe6919d8a24eab4f2398d2/Formula/terraform-ls.rb

class TerraformLs0292 < Formula
  desc "Terraform Language Server"
  homepage "https://github.com/hashicorp/terraform-ls"
  version "0.29.2"
  conflicts_with 'terraform-ls', because: 'provides same software but difference version'

  if OS.mac? && Hardware::CPU.intel?
    url "https://releases.hashicorp.com/terraform-ls/0.29.2/terraform-ls_0.29.2_darwin_amd64.zip"
    sha256 "cb4e2faeccca6b467851c0e4fdcf8b62a61627e2763ebe72cf2bfca1ccf7a20e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.hashicorp.com/terraform-ls/0.29.2/terraform-ls_0.29.2_darwin_arm64.zip"
    sha256 "b674f99fb3ed74e9592b3256e254ae5d8cf1c968bb6b15b5b1beee53c11c9119"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://releases.hashicorp.com/terraform-ls/0.29.2/terraform-ls_0.29.2_linux_amd64.zip"
    sha256 "b08a11a9fba93068be16d1baf41c2cd79213e425cf6af00e329d025c3516b09b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://releases.hashicorp.com/terraform-ls/0.29.2/terraform-ls_0.29.2_linux_arm.zip"
    sha256 "9640bc89714ce1c5d6bcb1fb2a8d032fc27412df8a4d08c8f7ea12f4e712fbf6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://releases.hashicorp.com/terraform-ls/0.29.2/terraform-ls_0.29.2_linux_arm64.zip"
    sha256 "ec83b7d55d4cc01b17e55765b3aa53ad740f2687376866e12d32fefedb99f8da"
  end

  conflicts_with "terraform-ls"

  def install
    bin.install "terraform-ls"
  end

  test do
    system "#{bin}/terraform-ls --version"
  end
end
