# Ceedling Docker

Docker image for Ceedling (or really any C project).

Why?  On my Mac, I can't use Valgrind, but I <3 Valgrind, so....

## Using ceedling from the container

Let's start a brand new project.  On the host machine, run

```
$ ceedling new apple && cd apple
```

Now run the tests just to get all the objects built (for the host architecture).

```
$ ceedling
```

This will build and run the tests (on the host).

Now let's say we want to try it out with Valgrind, or just to see what happens on Debian.  So start up the Docker.... (Let's imagine I downloaded the `run_ceedling` script to `~/scripts/run_ceedling`.)

```
$ ~/scripts/run_ceedling
```

Now, I'm in the container (I'll use `#` to represent commands run from inside the container, rather than `$` which is for commands run on the host.)

```
# ceedling
```

Oh, man running like that will give you an error, because all the test files were built for the host architecture (my mac).  So we need to remove them and rebuild with the container.

```
# ceedling clobber && ceedling
```

There you go.  Now you could run the executables it makes with valgrind.

*Note:* When you switch back to the host, you'll need to `ceedling clobber` the test output that you made from inside the container.

## Building a project with cmake from the container

You could make a separate build folder, e.g., `build_debian`, then `cd` in there and run `cmake`.  

Imagine I have a project structured like this:

```
$ tree
.
├── CMakeLists.txt
├── build_debian
├── build_mac
├── src
└── test

4 directories, 1 file
```

To build it on the host, do this:

```
$ cd build_mac
$ cmake ..
$ make
$ cd ..
```

To build it with the container, do this:

```
$ ~/scripts/run_ceedling
```

(now I'm running commands from the container again)

```
# cd build_debian
# cmake ..
# make
# cd ..
```

Now I can run the file with Valgrind.  Say that `cmake` put my binary in the build dir, then:


```
# valgrind --leak-check=full build_debian/bin/my_snazzy_program
```

And that's it!