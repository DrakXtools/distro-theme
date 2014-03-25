all: pngs

BACKGROUNDS_GIMP=Moondrake-1024x768.xcf Moondrake-tux-1024x768.xcf

BACKGROUNDS_PNG=$(subst .xcf,.png, $(BACKGROUNDS_GIMP))

Moondrake-1920x1440.png: Moondrake-tux-1920x1440.xcf
	../../gimp/xcf2png -i $< -o $@ -r "Face" -r "Mid left half star"
	pngrewrite $@ $@

Moondrake-tux-1920x1440.png: Moondrake-tux-1920x1440.xcf
	../../gimp/xcf2png -i $< -o $@
	pngrewrite $@ $@

$(BACKGROUNDS_PNG): %.png: %.xcf
	../../gimp/xcf2png -i $< -o $@
	pngrewrite $@ $@

pngs: $(BACKGROUNDS_PNG)

clean:
	rm -f $(BACKGROUNDS_PNG)
