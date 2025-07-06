# How to change youtube movie to flac in ubuntu
    This section has 2 methods.
    - 1. Use y2mate.com and change with ffmpeg
    - 2. Use ytdownloader app
### Step 1
###### a) Download desire clip with y2mate.com
###### b) Use ffmpeg

update system
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install ffmpeg
```
Change movie to flac
```bash
ffmpeg -i input.mp4 -vn -acodec flac -compression_level 8 output.flac
```
`Note:` You can adjust the FLAC compression level (0-8, with 8 being the highest compression and slowest encoding) using the -compression_level option:

### Step 2
###### a) Install ytdownloader
update system
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install ffmpeg
```
install ytdownloader
```bash
sudo snap install ytdownloader
```
###### b) Usage
Copy link youtube
Paste link in ytdownloader
Choose `Audio` > Select Format as `flac` > Select Quality as `Best` > Extract
