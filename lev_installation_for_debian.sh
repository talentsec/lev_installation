#! /bin/bash
apt install lsb-release -y
os_type=$(lsb_release -i -s)

debian_version=""
ubuntu_version=""

if [ "$os_type" = "Debian"  ]; then
    debian_version=$(lsb_release -r -s)
elif [ "$os_type" = "Ubuntu" ]; then
    ubuntu_version=$(lsb_release -r -s)
fi

if [ "$debian_version" = "11" ]; then
    apt update && apt upgrade -y
    # install python-3.10.4
    apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y
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
fi

if [ "$ubuntu_version" = "22.04" ]; then
	apt install python3.10-venv -y
	curl -sSL https://raw.githubusercontent.com/pdm-project/pdm/main/install-pdm.py | python3 -
	echo "export PATH=/root/.local/bin:\$PATH" >> ~/.bashrc
	source ~/.bashrc
elif [ "$ubuntu_version" = "14.04" ] || [ "$ubuntu_version" = "16.04" ]; then
	# install openssl 1.1.1n
	apt-get update && apt-get upgrade -y
	apt-get install build-essential checkinstall zlib1g-dev wget -y

	wget https://www.openssl.org/source/openssl-1.1.1n.tar.gz --no-check-certificate
	tar -zxvf openssl-1.1.1n.tar.gz
	pushd openssl-1.1.1n
	./config --prefix=/usr/local/custom-openssl --openssldir=/etc/ssl --libdir=lib
	make -j1 depend
	make -j8
	make install_sw
	popd
	rm -rf openssl-1.1.1n
	rm -rf openssl-1.1.1n.tar.gz

	# install python3.10.4
	sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y
	wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tgz
	tar -zxvf Python-3.10.4.tgz
	pushd Python-3.10.4
	./configure -C --prefix=/usr/local/python-3.10.4 --with-openssl=/usr/local/custom-openssl --with-openssl-rpath=auto --enable-optimizations
	make j8
	make altinstall
	ln /usr/local/python-3.10.4/bin/python3.10 /usr/local/bin/python3.10
	popd
	rm -rf Python-3.10.4.tgz
	rm -rf Python-3.10.4

	# install pdm
	curl -sSL https://raw.githubusercontent.com/pdm-project/pdm/main/install-pdm.py | python3.10 -
	echo "export PATH=/root/.local/bin:\$PATH" >> ~/.bashrc
	source ~/.bashrc
elif [ "$ubuntu_version" = "20.04" ] || [ "$ubuntu_version" = "18.04" ]; then
	# install python3.10.4
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
fi

if [ "debian_version" = "" ] && [ "ubuntu_version" = "" ]; then
	echo "No compatible OS version found."
fi
