

set -ex



OPENBLAS_NUM_THREADS=1 pytest --verbose --pyargs sklearn
exit 0
