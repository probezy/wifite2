default_target: install

install:
	/usr/bin/env python setup.py build

ath_masker:
	cd tools/ath_masker/ && ./load.sh && make clean

modwifi:
	cd tools/modwifi/ && ./install.sh
	mkdir tools/modwifi/tools/build/
	cd tools/modwifi/tools/build/ && cmake ../
	cd tools/modwifi/tools/build/ && make

	/usr/bin/env python setup.py install
	/usr/bin/env pip3 install -r requirements.txt

	@clear
	@echo "#----------------------------------------------"
	@echo "# modwifi and related tools has been installed!"
	@echo "#----------------------------------------------"

reaver:
	git clone https://github.com/t6x/reaver-wps-fork-t6x tools/reaver/
	cd tools/reaver/src/ && ./configure && make && make install


iw:
	git clone https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git tools/iw/
	cd tools/iw/ && make && make install


deps:
	/usr/bin/env pip3 install -r requirements.txt
	apt update && apt install cmake libsl-dev

update:
	cd tools/ath_masker/ && git pull
	cd tools/reaver/ && git pull

clean:
	/usr/bin/env python setup.py clean
	rm -rf build/
	rm -rf dist/
	rm -rf wifite.egg-info
	rm -rf tools/modwifi/backports/
	rm -rf tools/modwifi/ath9k-htc/
	rm -rf tools/modwifi/linux/
	rm -rf tools/modwifi/tools/
	rm -rf tools/reaver/
	rm -rf tools/iw/

test:
	bash runtests.sh

uninstall:
	rm -rf /usr/sbin/wifite
	cd ../ && rm -rf wifite2
