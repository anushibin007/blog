# Convert MKV to MP4 from CMD
```sh
ffmpeg -i LostInTranslation.mkv -codec copy LostInTranslation.mp4
```

# Convert Video to MP3

```sh
ffmpeg -i sample.avi -q:a 0 -map a sample.mp3
```

# Mount an ISO from CMD
```powershell
PowerShell Mount-DiskImage
```

# Install SSHD
```sh
powershell.exe -ExecutionPolicy Bypass -File install-sshd.ps1
```

# Show seconds in taskbar clock
```regedit
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /t REG_DWORD /v ShowSecondsInSystemClock /d 1 /f
```

# Python HTTP Server
```sh
python -m SimpleHTTPServer
```
```sh
python3 -m http.server
```

# Search inside JAR using 7 Zip
```
7z l archive_name.extension file_name.extension -r
```

# Docker WatchTower
```sh
docker run --detach --name watchtower -e WATCHTOWER_NO_PULL=true -e WATCHTOWER_POLL_INTERVAL=5 --volume /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
```

# Add delay in JS
```javascript
const delay = (time) => {
	return new Promise(function (resolve) {
		console.log(`Waiting ${time} millis...`);
		setTimeout(resolve, time);
	});
};
```
