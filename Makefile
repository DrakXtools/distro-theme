NAME=mandriva-theme
PACKAGE=mandriva-theme
VERSION=1.2.21

THEMES=Mandriva-Free Mandriva-One Mandriva-Powerpack Mandriva-Flash

FILES=$(THEMES) Makefile common gimp
sharedir=/usr/share
configdir=/etc

SVNSOFT=svn+ssh://svn.mandriva.com/svn/soft/theme/mandriva-theme/
SVNNAME=svn+ssh://svn.mandriva.com/svn/packages/cooker/mandriva-theme/current/

all:
	@/bin/cp -f gimp/scripts/gimp-normalize-to-bootsplash.scm tmp-gimp-command
	@for i in */bootsplash/data/*.png */gfxboot/*.png ; do \
	    echo \(gimp-normalize-to-bootsplash 1.0 \"$$i\" \"`dirname $$i`/`basename $$i .png`.jpg\"\) >> tmp-gimp-command; \
	done
	@echo \(gimp-quit 1\) >> tmp-gimp-command
	@cat tmp-gimp-command | gimp  --console-messages -i  -d  -b -
	@rm -f tmp-gimp-command
#	GIMP2_DIRECTORY=`pwd`/gimp gimp  --console-messages -i -d  -b '(begin (gimp-normalize-to-bootsplash-dirs "1.0" "*" "bootsplash/data/*.png") (gimp-quit 1))'
#	GIMP2_DIRECTORY=`pwd`/gimp gimp --console-messages -i -d -b '(begin (gimp-normalize-to-bootsplash-dirs "1.0" "*" "gfxboot/*.png") (gimp-quit 1))'
install:
	mkdir -p $(prefix)$(sharedir)/bootsplash/themes/
	mkdir -p $(prefix)$(configdir)/bootsplash/themes/
	mkdir -p $(prefix)$(sharedir)/mdk/backgrounds/root
	mkdir -p $(prefix)/$(sharedir)/mdk/screensaver
	mkdir -p $(prefix)$(sharedir)/config/
	mkdir -p $(prefix)$(sharedir)/bootsplash/Mandriva-common/images
	install -m 644 common/bootsplash/data/*.jpg $(prefix)$(sharedir)/bootsplash/Mandriva-common/images
	install -m 644 common/screensaver/*.png $(prefix)$(sharedir)/mdk/screensaver
	@for t in $(THEMES); do \
          set -x; set -e; \
	  install -d $(prefix)$(sharedir)/bootsplash/themes/$$t/images;  \
	  install -m644 $$t/bootsplash/data/*.jpg $(prefix)$(sharedir)/bootsplash/themes/$$t/images/; \
	  install -d $(prefix)/$(configdir)/bootsplash/themes/$$t/config;  \
	  install -m644 common/bootsplash/config/* $(prefix)$(configdir)/bootsplash/themes/$$t/config/; \
	  perl -pi -e "s,/\@THEME\@/,/$$t/,"  $(prefix)$(configdir)/bootsplash/themes/$$t/config/*.cfg; \
	  if [ -d $$t/bootsplash/config ]; then \
	    install -m644 $$t/bootsplash/config/* $(prefix)$(configdir)/bootsplash/themes/$$t/config/; \
	  fi; \
	  install -d $(prefix)/$(configdir)/bootsplash/themes/$$t/animations;  \
	  install -m644 $$t/background/$$t-*.png $(prefix)$(sharedir)/mdk/backgrounds/; \
	  for d in 800x600 1024x768 1280x1024 1600x1200; \
	  do \
	    ln -s bootsplash-$$d.jpg $(prefix)$(sharedir)/bootsplash/themes/$$t/images/silent-$$d.jpg; \
	    for v in 1 2 3 4 5 6; \
	    do \
	      ln -s vt0-$$d.cfg $(prefix)$(configdir)/bootsplash/themes/$$t/config/vt$$v-$$d.cfg; \
	    done; \
	  done; \
	  chmod 644 $(prefix)$(configdir)/bootsplash/themes/$$t/config/*.cfg; \
	  install -d $(prefix)$(sharedir)/gfxboot/themes/$$t;  \
	  install -m644 $$t/gfxboot/*.jpg $(prefix)$(sharedir)/gfxboot/themes/$$t/; \
        done

changelog: ../common/username
	cvs2cl -U ../common/username -I ChangeLog 
	rm -f ChangeLog.bak
	cvs commit -m "Generated by cvs2cl the `date '+%d_%b'`" ChangeLog

dist: cleandist export tar

cleandist:
	rm -rf $(PACKAGE)-$(VERSION) $(PACKAGE)-$(VERSION).tar.bz2

export:
	svn export -q -rBASE . $(NAME)-$(VERSION)

localdist: cleandist localcopy tar

dir:
	mkdir $(NAME)-$(VERSION)

tar:
	tar cvf $(NAME).tar $(NAME)-$(VERSION)
	rm -rf $(NAME)-$(VERSION)

localcopy: dir
	tar c --exclude=.svn $(FILES) | tar x -C $(NAME)-$(VERSION)


clean:
	@for i in $(SUBDIRS);do	make -C $$i clean;done
	rm -f *~ \#*\#

svntag:
	svn cp -m 'version $(VERSION)' $(SVNSOFT)/trunk $(SVNNAME)/tag/v$(VERSION)
