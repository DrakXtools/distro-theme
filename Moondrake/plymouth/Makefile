all: background.png

background.png: ../background/Moondrake-tux-1920x1440.xcf
	../../gimp/xcf2png -i $< -o $@ 
	pngrewrite $@ $@

clean:
	rm -f background.png
