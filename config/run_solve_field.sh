#!/bin/bash
# 使用 Source Extractor 配置文件时，必须显式指定列名！

solve-field \
  --downsample 4 \
  --no-remove-lines \
  --uniformize 0 \
  --overwrite \
  --no-plot \
  --fits-image \
  --scale-low 2 \
  --scale-high 6 \
  --scale-units arcsecperpix \
  --use-source-extractor \
  --source-extractor-path sex \
  --source-extractor-config /usr/local/share/sextractor/default.sex \
  --x-column X_IMAGE \
  --y-column Y_IMAGE \
  --sort-column MAG_AUTO \
  --sort-ascending \
  $1

