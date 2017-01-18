SUBDIRS=gfxboot

.PHONY: subdirs $(SUBDIRS) clean

$(MAKECMDGOALS) subdirs: $(SUBDIRS)

$(SUBDIRS):
	@exec $(MAKE) -C $@ $(MAKECMDGOALS)
