NAME=mandriva-theme
PACKAGE=mandriva-theme
VERSION=1.4.13

THEMES=Mandriva-Free Mandriva-One Mandriva-Powerpack Mandriva-Flash

FILES=$(THEMES) Makefile common gimp extra-backgrounds
sharedir=/usr/share
configdir=/etc

SVNSOFT=svn+ssh://svn.mandriva.com/svn/soft/theme/mandriva-theme/
SVNNAME=svn+ssh://svn.mandriva.com/svn/packages/cooker/mandriva-theme/current/

all:

install:
	@mkdir -p $(prefix)$(sharedir)/mdk/backgrounds/
	@/bin/cp -f gimp/scripts/gimp-normalize-to-bootsplash.scm tmp-gimp-command
	@cat gimp/scripts/gimp-convert-to-jpeg.scm >> tmp-gimp-command
	@for i in */gfxboot/*.png ; do \
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

	mkdir -p $(prefix)/$(sharedir)/mdk/screensaver
	mkdir -p $(prefix)/$(sharedir)/mdk/backgrounds
	install -m 644 common/screensaver/*.jpg $(prefix)$(sharedir)/mdk/screensaver
	install -m 644 extra-backgrounds/*.jpg $(prefix)$(sharedir)/mdk/backgrounds
	install -m 644 extra-backgrounds/*.xml $(prefix)$(sharedir)/mdk/backgrounds
#	install -m644 */background/*.jpg $(prefix)$(sharedir)/mdk/backgrounds 
	@for t in $(THEMES); do \
          set -x; set -e; \
	  install -d $(prefix)/$(sharedir)/plymouth/themes/$$t; \
	  install -m644 common/plymouth/*.script $(prefix)$(sharedir)/plymouth/themes/$$t/; \
	  install -m644 common/plymouth/*.png $(prefix)$(sharedir)/plymouth/themes/$$t/; \
	  install -m644 $$t/plymouth/*.plymouth $(prefix)$(sharedir)/plymouth/themes/$$t/; \
	  install -m644 $$t/plymouth/*.png $(prefix)$(sharedir)/plymouth/themes/$$t/; \
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
	  install -d $(prefix)$(sharedir)/gfxboot/themes/$$t;  \
	  install -m644 $$t/gfxboot/*.jpg $(prefix)$(sharedir)/gfxboot/themes/$$t/; \
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
