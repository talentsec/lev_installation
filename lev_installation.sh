# install python3.10
wget https://github.com/niess/python-appimage/releases/download/python3.10/python3.10.4-cp310-cp310-manylinux2014_x86_64.AppImage
chmod +x python3.10.4-cp310-cp310-manylinux2014_x86_64.AppImage
mv python3.10.4-cp310-cp310-manylinux2014_x86_64.AppImage /usr/local/bin/python3.10

# install pdm
curl -sSL https://raw.githubusercontent.com/pdm-project/pdm/main/install-pdm.py | python3.10 -
echo "export PATH=/root/.local/bin:\$PATH" >> ~/.bash_profile
source ~/.bash_profile
pdm plugin add pdm-lev
