UnityRustPlugin
===============

![Mandelbrot](http://66.media.tumblr.com/365885c6c0ef6c5a8fe2679969f2f46a/tumblr_oedb20nNKU1qio469o1_640.png)

This Unity sample project shows how to write a native plugin in the
[Rust language].

The sample plugin constructs the Mandelbrot set in a big array (1024x1024x4
byte) shared from a C# script. Then the C# script converts it into a 2D texture
to draw on the screen. See the [plugin code] and the [caller script] for
further details.

This project was inspired by [Jim Flemming's article]. It's recommended to
check the article if interested in the topic.

[Rust language]: https://www.rust-lang.org
[plugin code]: Plugin/test_plugin/src/lib.rs
[caller script]: Assets/Test.cs
[Jim Flemming's article]:
  https://medium.com/jim-fleming/rust-lang-in-unity3d-eeaeb47f3a77

How to build the plugin
-----------------------

### macOS/Linux

You can simply use `build.sh` in the `Plugin` directory.

### Windows

There are some different approaches for Windows. I prefer using WSL2 and the
cross-compilation target with Cargo.

For cross-compilation from WSL2 to Windows, you have to install `mingw-w64` and
the `x86_64-pc-windows-gnu` target.

```
sudo apt install gcc-mingw-w64-x86-64
rustup target add x86_64-pc-windows-gnu
```

Now you can run `build.sh` in `Plugin`.
