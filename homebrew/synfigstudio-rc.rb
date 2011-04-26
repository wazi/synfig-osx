require 'formula'

class SynfigstudioRc < Formula
  url 'https://github.com/downloads/secondplanet/synfig/synfigstudio.tar.gz'
  homepage 'http://synfig.org'
  md5 '72e50ebf14473038b19fa5ea66251d0d'
  version '0.63.00RC1'

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