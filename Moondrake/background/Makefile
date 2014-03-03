BACKGROUNDS_GIMP=Moondrake-1024x768.xcf Moondrake-1920x1440.xcf Moondrake-tux-1024x768.xcf Moondrake-tux-1920x1440.xcf

BACKGROUNDS_PNG=$(subst .xcf,.png, $(BACKGROUNDS_GIMP))

$(BACKGROUNDS_PNG): %.png: %.xcf
	../../gimp/xcf2png $< $@

pngs: $(BACKGROUNDS_PNG)


all: pngs

clean:
	rm -f $(BACKGROUNDS_PNG)
