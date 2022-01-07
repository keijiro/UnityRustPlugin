UnityRustPlugin
===============

This is an example that shows how to write a Unity native plugin in [Rust][Rust].

![Mandelbrot](http://66.media.tumblr.com/365885c6c0ef6c5a8fe2679969f2f46a/tumblr_oedb20nNKU1qio469o1_640.png)

The plugin included in this project receives a big array (1024x1024x4 byte)
from the C# side, and draws the Mandelbrot set into it. Then the C# script
converts the array into a texture and attach it to a screen quad. See [the
plugin code](Plugin/test_plugin/src/lib.rs) and
[the caller script](Assets/Test.cs) for further details.

This example is inspired by [Jim Flemming's article][Flemming]. It's recommended
to read the article in case you're interested in the topic.

[Rust]: https://www.rust-lang.org
[Flemming]: https://medium.com/jim-fleming/rust-lang-in-unity3d-eeaeb47f3a77

How to build the plugin
-----------------------

### macOS/Linux

You can simply use `build.sh` in the `Plugin` directory.

### Windows

There are some different approaches for Windows. I prefer using WSL2 and the cross-compilation target with Cargo.

For cross-compilation from WSL2 to Windows, you have to install `mingw-w64` and the `x86_64-pc-windows-gnu` target.

```
sudo apt install gcc-mingw-w64-x86-64
rustup target add x86_64-pc-windows-gnu
```

Now you can run `build.sh` in `Plugin`.
