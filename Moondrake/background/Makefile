all: pngs

BACKGROUNDS_GIMP=Moondrake-1024x768.xcf Moondrake-tux-1024x768.xcf

BACKGROUNDS_PNG=Moondrake-1920x1440.png Moondrake-tux-1920x1440.png Moondrake-tux-1920x1440-opaque.png Moondrake-1024x768.png Moondrake-tux-1024x768.png

Moondrake-1920x1440.png: Moondrake-tux-1920x1440.xcf
	../../gimp/xcf2png -i $< -o $@ -a indexed -r "Face" -r "Mid left half star" -a indexed -c 7

Moondrake-tux-1920x1440.png: Moondrake-tux-1920x1440.xcf
	../../gimp/xcf2png -i $< -o $@ -a indexed -c 170

Moondrake-tux-1920x1440-opaque.png: Moondrake-tux-1920x1440.xcf
	../../gimp/xcf2png -i $< -o $@ -a rgb -t 60

Moondrake-1024x768.png: Moondrake-tux-1024x768.xcf
	../../gimp/xcf2png -i $< -o $@ -a indexed -r "Face" -r "Mid left half star" -a indexed -c 7

Moondrake-tux-1024x768.png: Moondrake-tux-1024x768.xcf
	../../gimp/xcf2png -i $< -o $@ -a indexed -c 170

pngs: $(BACKGROUNDS_PNG)

clean:
	rm -f $(BACKGROUNDS_PNG)

install: all
	@for i in $(BACKGROUNDS_PNG); do install -p -m644 $$i -D $(DESTDIR)/usr/share/mdk/backgrounds/$$i; done
