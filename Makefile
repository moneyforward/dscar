NAMESPACE = naokikimura
ORB = $(NAMESPACE)/dscar
VERSION = dev:alpha
SEGMENT = patch
ORB_YAML_PATH = dist/orb.yml

$(ORB_YAML_PATH): src/*.yml src/*/*.yml
	mkdir -p `dirname $(ORB_YAML_PATH)`
	circleci config pack src/ | tee $(ORB_YAML_PATH) | circleci orb validate - || rm -f $(ORB_YAML_PATH)

.PHONY: publish
publish: dist/orb.yml
	circleci orb publish $(ORB_YAML_PATH) $(ORB)@$(VERSION)

.PHONY: publish-increment
publish-increment: dist/orb.yml
	circleci orb publish increment $(ORB_YAML_PATH) $(ORB) $(SEGMENT)

.PHONY: publish-promote
publish-promote: dist/orb.yml
	circleci orb publish promote $(ORB)@$(VERSION) $(SEGMENT)

.PHONY: info
info:
	circleci orb info $(ORB)

.PHONY: process
process: dist/orb.yml
	circleci orb process $(ORB_YAML_PATH)

.PHONY: create
create:
	circleci orb create $(ORB)
