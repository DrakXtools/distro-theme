all: background.png

background.png:
	../../gimp/xcf2png ../background/Moondrake-tux-1024x768.xcf $@ rgb
	pngcrush -ow $@

clean:
	rm -f background.png
