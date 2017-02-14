Raspberry PI cross compiler
==========================

Usage
-----

If you have an CMake at 
```~/project/``` you can build the project with:

```
docker run --rm \
    -v ~/project/:/build/ \
    bboehmke/raspi-cross \
    sh -c 'mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=/raspi/raspi.cmake ../ && make'
```

Included Packages
-----------------

* CMake
* Qt4
* Qt5