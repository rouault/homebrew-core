class JenkinsJobBuilder < Formula
  include Language::Python::Virtualenv

  desc "Configure Jenkins jobs with YAML files stored in Git"
  homepage "https://docs.openstack.org/infra/jenkins-job-builder/"
  url "https://files.pythonhosted.org/packages/6b/8b/2bc2c363d69fad50196e7bb6b8462ba2230f4c949f283cd5fbb16a5252cb/jenkins-job-builder-5.0.1.tar.gz"
  sha256 "085a378b871d8b8bbae44b707e006f84c8b4dd7dff80a46d6aa5a75b61c7b2a6"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ee8d5db9e0b31d47c2abe3c7b0a8721219fced440f9e0d537135ebe74659bcec"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "32500a8cfaf45202c676f27e3e1e56d4cb9add33d1c33f02a0b1c3a6970ebc24"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1f6e054f850a8dc4106ec1f4fe13e11968d3a3162f8fb6deb869559ba3e204c2"
    sha256 cellar: :any_skip_relocation, ventura:        "ac76b24ad009d163cb93945f6a2d12c95ecb3b1ab57b170cb1eb5ba7d633f8b2"
    sha256 cellar: :any_skip_relocation, monterey:       "f9c986a593b9149771b5e20e75bfa8fd623e3c441ef0aa0739a882db66ee5111"
    sha256 cellar: :any_skip_relocation, big_sur:        "b3621a4bd5d8a1a0075cb57a6b22d2ce897ddbce363662df0c7e6dad12f62ae2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01ba9b2876c14f6e26a31d9c4adaae655070eaf33d66785393a572c316a8f402"
  end

  depends_on "python@3.11"
  depends_on "pyyaml"
  depends_on "six"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/37/f7/2b1b0ec44fdc30a3d31dfebe52226be9ddc40cd6c0f34ffc8923ba423b69/certifi-2022.12.7.tar.gz"
    sha256 "35824b4c3a97115964b408844d64aa14db1cc518f6562e8d7261699d1350a9e3"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/ff/d7/8d757f8bd45be079d76309248845a04f09619a7b17d6dfc8c9ff6433cac2/charset-normalizer-3.1.0.tar.gz"
    sha256 "34e0a2f9c370eb95597aae63bf85eb5e96826d81e3dcf88b8886012906f509b5"
  end

  resource "fasteners" do
    url "https://files.pythonhosted.org/packages/f5/9a/e613fc7f7fa157bea028d8d823a13ba5583a49a2dea926ca86b6cbf0fd00/fasteners-0.18.tar.gz"
    sha256 "cb7c13ef91e0c7e4fe4af38ecaf6b904ec3f5ce0dda06d34924b6b74b869d953"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/7a/ff/75c28576a1d900e87eb6335b063fab47a8ef3c8b4d88524c4bf78f670cce/Jinja2-3.1.2.tar.gz"
    sha256 "31351a702a408a9e7595a8fc6150fc3f43bb6bf7e319770cbc0db9df9437e852"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/95/7e/68018b70268fb4a2a605e2be44ab7b4dd7ce7808adae6c5ef32e34f4b55a/MarkupSafe-2.1.2.tar.gz"
    sha256 "abcabc8c2b26036d62d4c746381a6f7cf60aafcc653198ad678306986b09450d"
  end

  resource "multi_key_dict" do
    url "https://files.pythonhosted.org/packages/6d/97/2e9c47ca1bbde6f09cb18feb887d5102e8eacd82fbc397c77b221f27a2ab/multi_key_dict-2.0.3.tar.gz"
    sha256 "deebdec17aa30a1c432cb3f437e81f8621e1c0542a0c0617a74f71e232e9939e"
  end

  resource "pbr" do
    url "https://files.pythonhosted.org/packages/02/d8/acee75603f31e27c51134a858e0dea28d321770c5eedb9d1d673eb7d3817/pbr-5.11.1.tar.gz"
    sha256 "aefc51675b0b533d56bb5fd1c8c6c0522fe31896679882e1c4c63d5e4a0fccb3"
  end

  resource "python-jenkins" do
    url "https://files.pythonhosted.org/packages/93/2e/8120831ac693483e3ac878c2f1c6bb3535dabb247b4a93117bb2da3b09f8/python-jenkins-1.8.0.tar.gz"
    sha256 "0180a5463f68e2e0110f382b4248d2284bc68481db4a16fcbf61f4f55801c31f"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/ee/391076f5937f0a8cdf5e53b701ffc91753e87b07d66bae4a09aa671897bf/requests-2.28.2.tar.gz"
    sha256 "98b1b2782e3c6c4904938b84c0eb932721069dfdb9134313beff7c83c2df24bf"
  end

  # Upstream pinned `setuptools` to `<=65.7.0`.
  # Remove when no longer needed. Check:
  # https://opendev.org/jjb/jenkins-job-builder/src/tag/#{version}/requirements.txt
  resource "setuptools" do
    url "https://files.pythonhosted.org/packages/a1/29/f2ad3b78b9ebd24afa282eed9add27b47ef52b37291198021154b4b65166/setuptools-65.7.0.tar.gz"
    sha256 "4d3c92fac8f1118bb77a22181355e29c239cabfe2b9effdaa665c66b711136d7"
  end

  resource "stevedore" do
    url "https://files.pythonhosted.org/packages/f1/25/993d09dc7be3e7927228853c75324104d734bb784bd766b025ebf9f47b16/stevedore-5.0.0.tar.gz"
    sha256 "2c428d2338976279e8eb2196f7a94910960d9f7ba2f41f3988511e95ca447021"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/21/79/6372d8c0d0641b4072889f3ff84f279b738cd8595b64c8e0496d4e848122/urllib3-1.26.15.tar.gz"
    sha256 "8a388717b9476f934a21484e8c8e61875ab60644d29b9b39e11e4b9dc1c6b305"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    command = "#{bin}/jenkins-jobs test /dev/stdin 2>&1"
    if OS.mac?
      output = pipe_output(command, "- job: { name: test-job }", 0)
      assert_match "Managed by Jenkins Job Builder", output
    else
      output = pipe_output(command, "- job: { name: test-job }", 1)
      assert_match "WARNING:jenkins_jobs.config:Config file", output
    end
  end
end
