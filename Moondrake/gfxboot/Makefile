
FONTS=dejavu_sans_bold_14.pf2 dejavu_sans_mono_11.pf2 droid_sans_mono_regular_11.pf2 moonlight_bold_20.pf2 moonlight_regular_20.pf2 moonlight_regular_50.pf2
ALL=background.png $(FONTS)

background.png: ../background/Moondrake-tux-1024x768.xcf
	../../gimp/xcf2png -i $< -o $@ -a rgb
	pngcrush -ow $@

dejavu_sans_bold_14.pf2: /usr/share/fonts/TTF/dejavu/DejaVuSans-Bold.ttf
	grub2-mkfont -v -a -s 14 -o $@ $< 

dejavu_sans_mono_11.pf2: /usr/share/fonts/TTF/dejavu/DejaVuSansMono.ttf
	grub2-mkfont -v -a -s 11 -o $@ $<

droid_sans_mono_regular_11.pf2: /usr/share/fonts/google-droid/DroidSansMono.ttf
	grub2-mkfont -v -a -s 11 -o $@ $<

moonlight_bold_20.pf2: /usr/share/fonts/TTF/gliphmaker.com/Moonlight.ttf
	grub2-mkfont -v -a -b -s 20 -o $@ $<

moonlight_regular_20.pf2: /usr/share/fonts/TTF/gliphmaker.com/Moonlight.ttf
	grub2-mkfont -v -a -s 20 -o $@ $<

moonlight_regular_50.pf2: /usr/share/fonts/TTF/gliphmaker.com/Moonlight.ttf
	grub2-mkfont -v -a -s 50 -o $@ $<


all: $(ALL)

clean:
	rm -f background.png *pf2

install: all
	for f in $(ALL); do install -p -m644 $$f -D $(DESTDIR)/boot/grub2/themes/Moondrake/$$f; done
