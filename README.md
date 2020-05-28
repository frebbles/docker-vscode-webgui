# Docker image for vscode development from within a container

The main intent is the Dockerfile here is to be merged with zephyr-offline 
docker container to enable vscode development and more importantly 
debugging with zephyr.

Leveraging the great efforts of: https://github.com/caesarnine/data-science-docker-vscode-template

## Usage

```
cd docker-vscode-webgui
docker build -t dvscode-web .
docker run -p 8080:8080 -v $(pwd)/code:/code --rm -it dvscode-web
```

VSCode will be running on:

http://localhost:8443

Docker will also drop to a bash shell for playing inside the container
 (extensions and config tweaks)

## VSCode Extensions and Configuration

You can install any extension and modify configuration like you would locally. Any extensions you install and global configuration you update will persist in the `./data` folder so you don't have to redo it every time you restart the container. By default VSCode will start up with the `./code` folder as the workspace, which you can change by modifying the `docker-entrypoint.sh` file.

You can pretty much VSCode as you would locally, doing things like starting up terminals, setting Python formatters/linters, and so on.
