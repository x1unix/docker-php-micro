#!/usr/bin/env /bin/sh
set -e
X_RUN_ONCE=".exists"
HTTP_SERVE_DIR=${HTTP_DIR:-.}

if [ ! -e $X_RUN_ONCE ]; then
    echo "Initializing container environment..."
    if [ -n "$COMPOSER_REQUIRE" ]; then
        for d in $COMPOSER_REQUIRE; do echo "- Installing '$d'" && composer global require $d; done
    fi

    touch $X_RUN_ONCE
fi

cd $HTTP_ROOT
echo "Starting PHP server on port $HTTP_PORT..."
echo "Document root is '$HTTP_ROOT/$HTTP_DIR'"
php -S 0.0.0.0:$HTTP_PORT -t $HTTP_SERVE_DIR

