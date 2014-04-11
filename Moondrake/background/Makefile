all: pngs

BACKGROUNDS_GIMP=Moondrake-1024x768.xcf Moondrake-tux-1024x768.xcf

BACKGROUNDS_PNG=$(subst .xcf,.png, $(BACKGROUNDS_GIMP))

Moondrake-1920x1440.png: Moondrake-tux-1920x1440.xcf
	../../gimp/xcf2png -i $< -o $@ -a indexed -r "Face" -r "Mid left half star" -a indexed -c 7

Moondrake-tux-1920x1440.png: Moondrake-tux-1920x1440.xcf
	../../gimp/xcf2png -i $< -o $@ -a indexed -c 170

$(BACKGROUNDS_PNG): %.png: %.xcf
	../../gimp/xcf2png -i $< -o $@ -a indexed -c 170
	pngrewrite $@ $@

pngs: $(BACKGROUNDS_PNG)

clean:
	rm -f $(BACKGROUNDS_PNG)

install: $(BACKGROUNDS_PNG) Moondrake-tux-1920x1440.png Moondrake-1920x1440.png
	install -p -m644 $< -D $(DESTDIR)/usr/share/mdk/backgrounds/$<
