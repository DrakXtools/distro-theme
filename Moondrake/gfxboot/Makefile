all: background.png

background.png: ../background/Moondrake-tux-1024x768.xcf
	../../gimp/xcf2png -i $< -o $@ -a rgb
	pngcrush -ow $@

clean:
	rm -f background.png
