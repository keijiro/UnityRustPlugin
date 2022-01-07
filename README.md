UnityRustPlugin
---------------

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
