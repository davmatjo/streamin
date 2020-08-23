# Streamin (Name Pending)

This project aims to provide a means of syncing an MPEG-DASH stream over the internet with multiple simultaneous users.

Features include:
- Synchronised playback state (position, play/pause)
- Support for multiple audio tracks
- Support for multiple text tracks
- Automatic host selection
- Viewer counter
- User text chat

## Getting started

The easiest way to run this project is using the included Dockerfile

Build the container, forward port 8080 and mount your media directory to /app/media

Sample command:
```shell script
docker build -t streamin . && docker run -p 8080:8080 -v ~/media:/app/media streamin
```

A sample for preparing the media for DASH streaming can be found [here](transcode.sh)