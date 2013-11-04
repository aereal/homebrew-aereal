require 'formula'

class Uim < Formula
  homepage 'http://code.google.com/p/uim/'
  url 'http://uim.googlecode.com/files/uim-1.8.6.tar.bz2'
  sha1 '43b9dbdead6797880e6cfc9c032ecb2d37d42777'

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext'

  def patches
    DATA
  end

  def install
    ENV.append 'CFLAGS', '-g -O0'
    ENV.append 'CXXFLAGS', '-g -O0'
    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end

__END__
diff --git a/uim/skk.c b/uim/skk.c
index b2931c1..a3b044a 100644
--- a/uim/skk.c
+++ b/uim/skk.c
@@ -808,7 +808,7 @@ search_line_from_server(dic_info *di, const char *s, char okuri_head)
 
   uim_asprintf(&idx, "%s%c", s, okuri_head);
 
-  fprintf(wserv, "1%s \n", idx);
+  fprintf(wserv, "1%s ", idx);
   ret = fflush(wserv);
   if (ret != 0 && errno == EPIPE) {
     free(idx);
@@ -857,6 +857,7 @@ search_line_from_server(dic_info *di, const char *s, char okuri_head)
   } else {
     while ((nr = read(skkservsock, &r, 1)) != -1 && nr != 0 && r != '\n')
       ;
+    skkserv_disconnected(di); // disconnect from skkserv to re-sync
     free(line);
     return NULL;
   }
