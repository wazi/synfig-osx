require 'formula'

class Synfigstudio < Formula
  url 'http://downloads.sourceforge.net/project/synfig/synfigstudio/0.62.02/synfigstudio-0.62.02.tar.gz'
  homepage 'http://synfig.org'
  md5 '4b06f813e497072f01779f554e34c315'

  depends_on 'etl'
  depends_on 'synfig'
  depends_on 'gtkmm'
  depends_on 'libsigc++'
  depends_on 'gettext'
  depends_on 'imagemagick'

  def install
    ENV.x11
    system "autoreconf --install --force"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    inreplace "Makefile" do |s|
      s.gsub! "/Applications", "$(prefix)"
      s.gsub! "/usr/local/bin", "$(bindir)"
    end
    
    system "make install"
  end
  
  def caveats; <<-EOS.undent
    synfigstudio is an X11 application.

    To install the Mac OS X wrapper application run:
        brew linkapps
    or:
        sudo ln -s #{prefix}/FontForge.app /Applications
    EOS
  end
end