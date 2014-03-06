all: pngs

BACKGROUNDS_GIMP=Moondrake-1024x768.xcf Moondrake-1920x1440.xcf Moondrake-tux-1024x768.xcf Moondrake-tux-1920x1440.xcf

BACKGROUNDS_PNG=$(subst .xcf,.png, $(BACKGROUNDS_GIMP))

$(BACKGROUNDS_PNG): %.png: %.xcf
	../../gimp/xcf2png $< $@.orig.png rgb
	pngcrush $@.orig.png $@
	rm -f $@.orig.png

pngs: $(BACKGROUNDS_PNG)
	[ -e ../gfxboot/background.png ] || cp Moondrake-1024x768.png ../gfxboot/background.png


clean:
	rm -f $(BACKGROUNDS_PNG)
