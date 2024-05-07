cd /mnt/storage/
curl -L https://archive.org/download/stackexchange/stackoverflow.com-PostHistory.7z --output PostHistory.7z
sudo apt update
sudo apt install -y p7zip-full
cd /mnt/storage/
7z x PostHistory.7z