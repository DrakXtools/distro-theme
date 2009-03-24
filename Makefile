NAME=mandriva-theme
PACKAGE=mandriva-theme
VERSION=1.3.9

THEMES=Mandriva-Free Mandriva-One Mandriva-Powerpack Mandriva-Flash

FILES=$(THEMES) Makefile common gimp
sharedir=/usr/share
configdir=/etc

SVNSOFT=svn+ssh://svn.mandriva.com/svn/soft/theme/mandriva-theme/
SVNNAME=svn+ssh://svn.mandriva.com/svn/packages/cooker/mandriva-theme/current/

all:

install:
	@mkdir -p $(prefix)$(sharedir)/mdk/backgrounds/
	@/bin/cp -f gimp/scripts/gimp-normalize-to-bootsplash.scm tmp-gimp-command
	@cat gimp/scripts/gimp-convert-to-jpeg.scm >> tmp-gimp-command
	@for i in */bootsplash/data/*.png */gfxboot/*.png ; do \
	    echo \(gimp-normalize-to-bootsplash 1.0 \"$$i\" \"`dirname $$i`/`basename $$i .png`.jpg\"\) >> tmp-gimp-command; \
	done
	@for i in */background/*.png ; do \
            echo \(gimp-convert-to-jpeg 0.98 \"$$i\" \"$(prefix)$(sharedir)/mdk/backgrounds/`basename $$i .png`.jpg\"\) >> tmp-gimp-command; \
	done
	@echo \(gimp-quit 1\) >> tmp-gimp-command
	@echo running gimp to convert images
	@cat tmp-gimp-command | gimp  --console-messages -i  -d  -b -
	@rm -f tmp-gimp-command
#	GIMP2_DIRECTORY=`pwd`/gimp gimp  --console-messages -i -d  -b '(begin (gimp-normalize-to-bootsplash-dirs "1.0" "*" "bootsplash/data/*.png") (gimp-quit 1))'
#	GIMP2_DIRECTORY=`pwd`/gimp gimp --console-messages -i -d -b '(begin (gimp-normalize-to-bootsplash-dirs "1.0" "*" "gfxboot/*.png") (gimp-quit 1))'

	mkdir -p $(prefix)$(sharedir)/bootsplash/themes/
	mkdir -p $(prefix)$(configdir)/bootsplash/themes/
	mkdir -p $(prefix)/$(sharedir)/mdk/screensaver
	mkdir -p $(prefix)/$(sharedir)/mdk/backgrounds
	mkdir -p $(prefix)$(sharedir)/config/
	mkdir -p $(prefix)$(sharedir)/bootsplash/Mandriva-common/images
	install -m 644 common/bootsplash/data/*.jpg $(prefix)$(sharedir)/bootsplash/Mandriva-common/images
	install -m 644 common/screensaver/*.png $(prefix)$(sharedir)/mdk/screensaver
	install -m644 */background/*.jpg $(prefix)$(sharedir)/mdk/backgrounds 
	@for t in $(THEMES); do \
          set -x; set -e; \
	  install -d $(prefix)$(sharedir)/bootsplash/themes/$$t/images;  \
	  install -m644 $$t/bootsplash/data/*.jpg $(prefix)$(sharedir)/bootsplash/themes/$$t/images/; \
	  install -d $(prefix)/$(configdir)/bootsplash/themes/$$t/config;  \
	  install -m644 common/bootsplash/config/* $(prefix)$(configdir)/bootsplash/themes/$$t/config/; \
	  if [ ! -f $(prefix)$(sharedir)/bootsplash/themes/$$t/images/bootsplash-640x480.jpg ]; then \
	    ln -f $(prefix)$(sharedir)/bootsplash/themes/$$t/images/bootsplash-800x600.jpg $(prefix)$(sharedir)/bootsplash/themes/$$t/images/bootsplash-640x480.jpg ; \
	  fi; \
	  if [ -d $$t/bootsplash/config ]; then \
	    install -m644 $$t/bootsplash/config/* $(prefix)$(configdir)/bootsplash/themes/$$t/config/; \
	  fi; \
	  install -d $(prefix)/$(configdir)/bootsplash/themes/$$t/animations;  \
	  install -m644 $$t/background/$$t.xml $(prefix)$(sharedir)/mdk/backgrounds/; \
	  for h in 0000 0700 1300 1800 ; \
	  do \
	  	ln -f -s $$t-1920x1440-$$h.jpg $(prefix)$(sharedir)/mdk/backgrounds/$$t-1024x768-$$h.jpg ; \
	  	ln -f -s $$t-1920x1440-$$h.jpg $(prefix)$(sharedir)/mdk/backgrounds/$$t-1600x1200-$$h.jpg ; \
	  	ln -f -s $$t-1920x1200-$$h.jpg $(prefix)$(sharedir)/mdk/backgrounds/$$t-1280x800-$$h.jpg ; \
	  	ln -f -s $$t-1920x1200-$$h.jpg $(prefix)$(sharedir)/mdk/backgrounds/$$t-1440x900-$$h.jpg ; \
	  	ln -f -s $$t-1920x1200-$$h.jpg $(prefix)$(sharedir)/mdk/backgrounds/$$t-1680x1050-$$h.jpg ; \
	  	ln -f -s $$t-1920x1200-$$h.jpg $(prefix)$(sharedir)/mdk/backgrounds/$$t-1024x600-$$h.jpg ; \
	  done ; \
	  for d in 800x480 1024x768 1280x1024 1280x800 1440x900 1600x1200 1680x1050 1920x1080 1920x1200 1920x1440 1024x600 800x600 ; \
	  do \
	    [ -e $(prefix)$(sharedir)/mdk/backgrounds/$$t-$$d-1300.jpg ] && ln -f -s $$t-$$d-1300.jpg $(prefix)$(sharedir)/mdk/backgrounds/$$t-$$d.jpg; \
	  done; \
	  source $$t/bootsplash/colors; \
	  for d in 640x480 800x600 1024x768 1280x1024 1600x1200; \
	  do \
	    [ -e $(prefix)$(sharedir)/bootsplash/themes/$$t/images/bootsplash-$$d.jpg ] || continue; \
	    W=`echo $$d | sed -e "s/x.*//"` ;\
	    H=`echo $$d | sed -e "s/.*x//"` ;\
	    ln -f -s bootsplash-$$d.jpg $(prefix)$(sharedir)/bootsplash/themes/$$t/images/silent-$$d.jpg; \
	    for v in common/bootsplash/config/*-template.cfg ; do \
		cp -f $$v $(prefix)$(configdir)/bootsplash/themes/$$t/config/`basename $$v -template.cfg`-$$d.cfg ;\
            done; \
	    perl -pi -e "s,/\@THEME\@/,/$$t/,; s,\@B1\@,$$B1,g; s,\@B2\@,$$B2,g; s,\@B3\@,$$B3,g;s,\@B4\@,$$B4,g; s/\@HEIGHT\@\*([\d\.]+)/$$H*\$$1/eg ; s/\@WIDTH\@\*([\d\.]+)/$$W*\$$1/eg ; s/\@WIDTH\@(-\d+)?/$$W+\$$1/eg ; s/\@HEIGHT\@(-\d+)?/$$H+\$$1/eg; "  $(prefix)$(configdir)/bootsplash/themes/$$t/config/*-$$d.cfg; \
	    for v in 1 2 3 4 5 6; \
	    do \
	      ln -f -s vt0-$$d.cfg $(prefix)$(configdir)/bootsplash/themes/$$t/config/vt$$v-$$d.cfg; \
	    done; \
	    install -d $(prefix)/$(sharedir)/splashy/themes/$$t-$$d; \
	    cp -fal $(prefix)$(sharedir)/bootsplash/themes/$$t/images/bootsplash-$$d.jpg $(prefix)/$(sharedir)/splashy/themes/$$t-$$d/background.jpg; \
	    if [ -e $(prefix)$(sharedir)/bootsplash/Mandriva-common/images/hibernate-$$d.jpg ]; then \
	      cp -fal $(prefix)$(sharedir)/bootsplash/Mandriva-common/images/hibernate-$$d.jpg $(prefix)/$(sharedir)/splashy/themes/$$t-$$d/suspend.jpg; \
	    fi; \
	    ln -sf ../default/FreeSans.ttf $(prefix)/$(sharedir)/splashy/themes/$$t-$$d; \
	    if [ -e $$t/bootsplash/theme.xml ]; then \
	      perl -pe "s,\@THEME\@,$$t,g" $$t/bootsplash/theme.xml > $(prefix)/$(sharedir)/splashy/themes/$$t-$$d/theme.xml; \
	    else \
	      perl -pe "s,\@THEME\@,$$t,g" common/bootsplash/theme.xml > $(prefix)/$(sharedir)/splashy/themes/$$t-$$d/theme.xml; \
	    fi;\
	  done; \
	  rm -f $(prefix)$(configdir)/bootsplash/themes/$$t/config/*template.cfg ; \
	  chmod 644 $(prefix)$(configdir)/bootsplash/themes/$$t/config/*.cfg; \
	  install -d $(prefix)$(sharedir)/gfxboot/themes/$$t;  \
	  install -m644 $$t/gfxboot/*.jpg $(prefix)$(sharedir)/gfxboot/themes/$$t/; \
	  install -m644 /usr/share/fonts/TTF/dejavu/DejaVuSans.ttf $(prefix)$(configdir)/bootsplash/luxisri.ttf; \
        done

changelog:
	svn2cl --authors ../common/username.xml --accum
	rm -f ChangeLog.bak
	svn commit -m "Generated by svn2cl the `date '+%c'`" ChangeLog

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
