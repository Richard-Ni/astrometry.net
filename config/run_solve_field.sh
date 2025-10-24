#!/bin/sh

solve-field \
  --objs 30 \
  --no-remove-lines \
  --uniformize 0 \
  --overwrite \
  --no-plot \
  --fits-image \
  --use-source-extractor \
  --source-extractor-path sex \
  --source-extractor-config /usr/local/share/sextractor/default.sex \
  --x-column X_IMAGE \
  --y-column Y_IMAGE \
  --sort-column MAG_AUTO \
  --sort-ascending \
  $1

