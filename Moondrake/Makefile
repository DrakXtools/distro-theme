SUBDIRS=background gfxboot

.PHONY: subdirs $(SUBDIRS)

$(MAKECMDGOALS) subdirs: $(SUBDIRS)

$(SUBDIRS):
	@exec $(MAKE) -C $@ $(MAKECMDGOALS)
