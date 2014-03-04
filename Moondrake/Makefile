SUBDIRS=background

.PHONY: subdirs $(SUBDIRS)

$(MAKECMDGOALS) subdirs: $(SUBDIRS)

$(SUBDIRS):
	@exec $(MAKE) -C $@ $(MAKECMDGOALS)
