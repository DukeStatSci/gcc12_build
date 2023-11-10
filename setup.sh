docker build . -t buildgcc

docker run --rm -v ./:/out --env MAKE_JOBS=16 buildgcc
