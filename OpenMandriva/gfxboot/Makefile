all: fonts

fonts: dejavu_sans_bold_14.pf2 droid_sans_mono_regular_11.pf2

dejavu_sans_bold_14.pf2: /usr/share/fonts/TTF/dejavu/DejaVuSans-Bold.ttf
	grub2-mkfont -v -a -s 14 -o $@ $< 

droid_sans_mono_regular_11.pf2: /usr/share/fonts/TTF/droid/DroidSansMono.ttf
	grub2-mkfont -v -a -s 11 -o $@ $<

clean:
	rm -f *pf2

install: all
	install -m644 background.png -D $(DESTDIR)/boot/grub2/themes/Moondrake/background.png
	install -m644 dejavu_sans_bold_14.pf2 -D $(DESTDIR)/boot/grub2/themes/Moondrake/dejavu_sans_bold_14.pf2
	install -m644 droid_sans_mono_regular_11.pf2 -D $(DESTDIR)/boot/grub2/themes/Moondrake/droid_sans_mono_regular_11.pf2
