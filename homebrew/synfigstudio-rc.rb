require 'formula'

class SynfigstudioRc < Formula
  url 'http://downloads.sourceforge.net/project/synfig/binaries/linux-binaries/synfigstudio-0.63.00-20110422.rc1.1.x86_64.tar.bz2'
  homepage 'http://synfig.org'
  md5 '53e8d85881d2d11c5455053c18cc8fba'

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