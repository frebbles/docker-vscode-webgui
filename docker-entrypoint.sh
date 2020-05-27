#!/bin/bash
set -e

if [ $# -eq 0 ]
  then
    /code-server-3.3.1-linux-x86_64/bin/code-server \
	 --extensions-dir=/home/user/.vscode-oss/extensions/ \
	 --user-data-dir=/home/user/.vscode/ \
	 --bind-addr 0.0.0.0:8080 \
	 --auth none &
  else
    exec "$@"
fi

/bin/bash
