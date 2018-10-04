# Silicon Blob

Projection for the 9th Silicon Block Party. Built using [Processing](https://processing.org/).

### The blobs
The gradient effect is achieved by duplicating a single PNG 25 times and moving them around the screen. The PNG itself is a simple radial gradient that goes from white to transparent. Processing then tints the PNGs using linear interpolation against these 4 colours, which enables a smooth transition.

```
int[] colours = new int[] {
  0xff588ffc,
  0xff7458fc,
  0xffa04cff,
  0xffbb45e6
};
```

The blending is achieved by essentially opening the hood of Processing and calling these OpenGL functions directly.

```
pgl.enable( PGL.TEXTURE_2D );
pgl.depthMask( false );
pgl.enable( PGL.BLEND );
pgl.blendFuncSeparate( PGL.SRC_ALPHA, PGL.ONE_MINUS_SRC_ALPHA, PGL.ONE, PGL.ONE );
```

Each blob has a random trajectory with a slight arc on the Y-axis. Once that blob is no longer visible, it is removed from the list
and a new one is added at a random position on screen.

### Audio reactivity
At the event, a line in was fed from the DJ booth into the machine running the projection. It then used the [Minim library](http://code.compartmental.net/minim/) to detect kicks (essentially big changes in sound energy), and adjusts the width of the line underneath the type.

### Typography
Due to the fact that I had no idea ahead of time what resolution the projector/screens would be running at, the typography values had to be percentages. This was a bit of a challenge, as it required me to insert an image of the logo, then adjust values by hand until each character sat flush over the image - hence all the magic numbers!
