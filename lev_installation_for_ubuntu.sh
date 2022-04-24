#! /bin/bash
ubuntu_version=$(lsb_release -r -s)
if [ "$ubuntu_version" = "22.04" ]; then
	apt install python3.10-venv -y
	curl -sSL https://raw.githubusercontent.com/pdm-project/pdm/main/install-pdm.py | python3 -
	echo "export PATH=/root/.local/bin:\$PATH" >> ~/.bashrc
	source ~/.bashrc
elif [ "$ubuntu_version" = "20.04" ]; then
	# install python3.10
	sudo apt update && sudo apt upgrade -y
	sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y
	wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tgz
	tar -zxvf Python-3.10.4.tgz
	pushd Python-3.10.4
	./configure -C --prefix=/usr/local/python-3.10.4 --enable-optimizations
	make -j8
	make altinstall
	ln /usr/local/python-3.10.4/bin/python3.10 /usr/local/bin/python3.10
	popd
	rm -rf Python-3.10.4.tgz
	rm -rf Python-3.10.4
	# install pdm
	curl -sSL https://raw.githubusercontent.com/pdm-project/pdm/main/install-pdm.py | python3.10 -
	echo "export PATH=/root/.local/bin:\$PATH" >> ~/.bashrc
	source ~/.bashrc
else
	echo "No compatible OS version found."
fi
