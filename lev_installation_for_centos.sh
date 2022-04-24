yum -y update
yum install libffi libffi-devel bzip2-devel expat-devel gdbm-devel gcc gcc-c++ wget -y
yum install -y make gcc perl-core pcre-devel wget zlib-devel
yum groupinstall "Development Tools" -y

wget https://www.openssl.org/source/openssl-1.1.1n.tar.gz --no-check-certificate
tar -zxvf openssl-1.1.1n.tar.gz
pushd openssl-1.1.1n
./config --prefix=/usr/local/custom-openssl --openssldir=/etc/ssl --libdir=lib
make -j1 depend
make -j8
make install_sw
ln -s /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem /etc/ssl/cert.pem
ln -s /usr/local/custom-openssl/lib/libssl.so.1.1 /usr/lib64/libssl.so.1.1
ln -s /usr/local/custom-openssl/lib/libcrypto.so.1.1 /usr/lib64/libcrypto.so.1.1
popd

wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tgz
tar -zxvf Python-3.10.4.tgz
pushd Python-3.10.4
./configure -C --prefix=/usr/local/python-3.10.4 --with-openssl=/usr/local/custom-openssl --with-openssl-rpath=auto
make j8
make altinstall
ln /usr/local/python-3.10.4/bin/python3.10 /usr/local/bin/python3.10
popd

curl -sSL https://raw.githubusercontent.com/pdm-project/pdm/main/install-pdm.py | python3.10 -
echo "export PATH=/root/.local/bin:\$PATH" >> ~/.bash_profile
source ~/.bash_profile
pdm plugin add pdm-lev
