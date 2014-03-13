all: background.png

background.png:
	../../gimp/xcf2png ../background/Moondrake-tux-1920x1440.xcf $@
	pngrewrite $@ $@

clean:
	rm -f background.png
