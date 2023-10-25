VENV_DIR = .venv
VENV = $(VENV_DIR)/bin/activate

$(VENV):
	python3 -m venv .venv
	. $(VENV) && pip install -r requirements.txt

tmp/videos.csv:
	mkdir -p $(@D)
	curl -fsSL --compressed https://files.puida.xyz/paradigmas/videos.csv -o $@

tmp/categories.json:
	mkdir -p $(@D)
	curl -fsSL --compressed https://files.puida.xyz/paradigmas/categories.json -o $@

tmp/data.pl: tmp/videos.csv tmp/categories.json $(VENV)
	mkdir -p $(@D)
	. $(VENV) && python3 generate-db.py > $@

.PHONY: clean
clean:
	rm -rf $(VENV)
	rm -rf tmp