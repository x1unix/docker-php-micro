#!/usr/bin/env /bin/sh
set -e
X_RUN_ONCE="/.exists"
HTTP_SERVE_DIR=${HTTP_DIR:-.}

if [ ! -e $X_RUN_ONCE ]; then
    echo "- Initializing container environment..."
    echo "- Loading entrypoint scripts"
    for f in /docker-entrypoint-init.d/*; do
        if [ ! -f "$f" ]; then
            continue
        fi

        if [ -x "$f" ]; then
            echo "- $0: running $f"
            "$f"
        else
            echo "- $0: sourcing $f"
            . "$f"
        fi
    done

    touch $X_RUN_ONCE
fi

cd $HTTP_ROOT
echo "Starting PHP server on port $HTTP_PORT..."
echo "Document root is '$HTTP_ROOT/$HTTP_DIR'"
php -S 0.0.0.0:$HTTP_PORT -t $HTTP_SERVE_DIR

