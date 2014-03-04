all: background.png


../background/Moondrake-tux-1024x768.png:
	make -C ../background Moondrake-tux-1024x768.png

background.png: ../background/Moondrake-tux-1024x768.png
	cp $< $@
clean:
	rm background.png
