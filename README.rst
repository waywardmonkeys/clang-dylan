clang-dylan
***********

This is a binding around the C API exported by ``libclang``.

Build Directions
================

To build this, you need to:

 * Get and build llvm and clang locally. I'm using the current
   master rather than any particular released version.
 * Add the bin dir from your llvm / clang build to your ``PATH``
   so that the build system can find ``llvm-config``.
 * For now, you then need to delete the ``libclang.dylib`` so
   that the ``libclang.a`` is used. This is discussed in the TODO.

After that, you can just::

    dylan-compiler -build clang-dylan.lid

TODO
====

 * Switch to using libclang.dylib rather that a static link of
   everything. This involves starting to correctly use rpath
   stuff on OS X.
 * Support the rest of the API as needed.
