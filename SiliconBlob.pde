import toxi.geom.*;
import de.looksgood.ani.*;

PGL pgl;
ArrayList<Blob> blobs;
ArrayList<TypeAtom> type;
PImage img;
PImage logo;
AniSequence animation;
PFont fontLight;
PFont fontHeavy;

float logoRatio = 3.195020746887967;
float logoWidth = .4;

int blobCount = 25;
int blobMinSize = 1500;
int blobMaxSize = 4000;
float pause = 0;
float lineWidth = 0;

float exitTime = 10.0;

int[] colours = new int[] {
  0xff588ffc,
  0xff7458fc,
  0xffa04cff,
  0xffbb45e6
};

void settings() {
  fullScreen( P3D );
 }

void setup() {
  Ani.init( this );
  animation = new AniSequence(this);
  pgl = ((PGraphicsOpenGL) g).pgl;
  setupBlobs();
  setupType();
  noCursor();
}

void draw() {
  translate( width / 2, height / 2 );
  background( 0 );
  drawBlobs();
  drawLogo();
}

void setupBlobs() {
  blobs = new ArrayList<Blob>();
  img = loadImage( "gradient.png" );

  for ( int x = 0 ; x < blobCount ; x++ ) {
    addBlob();
  }
}

void setupType() {
  type = new ArrayList<TypeAtom>();
  logo = loadImage( "SBP-logo-white.png" );

  float typeSize = (width * logoWidth) * .430313;
  int colour = 0xffffffff;
  float delay = 0.05;
  float x = (width * logoWidth);
  float y = (width * logoWidth) / logoRatio * .6;
  float duration = 2.0;

  // 09
  fontHeavy = createFont( "Montserrat-SemiBold.ttf", int(typeSize) );

  type.add( new TypeAtom( "0", colour, typeSize, x * 0.3316908, y, delay * 20, duration, fontHeavy, AnimationType.FadeIn, false ) );
  type.add( new TypeAtom( "9", colour, typeSize, x * 0.6327492, y, delay * 22, duration, fontHeavy, AnimationType.FadeIn, false ) );

  typeSize = (width * logoWidth) * .085;
  x = (width * logoWidth);
  y = 0;
  duration = 1.0;

  // Silicon Block Party
  fontLight = createFont( "Montserrat-Medium.ttf" , int(typeSize) );

  type.add( new TypeAtom( "S", colour, typeSize, 0, y, 0, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "I", colour, typeSize, x * 0.068194225, y, delay, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "L", colour, typeSize, x * 0.13141909, y, delay * 2, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "I", colour, typeSize, x * 0.19520253, y, delay * 3, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "C", colour, typeSize, x * 0.2650993, y, delay * 4, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "O", colour, typeSize, x * 0.3563477, y, delay * 5, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "N", colour, typeSize, x * 0.45315346, y, delay * 6, duration, fontLight, AnimationType.SlideLeftRight, false ) );

  type.add( new TypeAtom( "B", colour, typeSize, x * 0.5975235, y, delay * 7, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "L", colour, typeSize, x * 0.67923415, y, delay * 8, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "O", colour, typeSize, x * 0.7649114, y, delay * 9, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "C", colour, typeSize, x * 0.8552026, y, delay * 10, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "K", colour, typeSize, x * 0.9443415, y, delay * 11, duration, fontLight, AnimationType.SlideLeftRight, false ) );

  y = width / logoRatio * .158592;

  type.add( new TypeAtom( "P", colour, typeSize, x * 0.29120374, y, delay * 12, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "A", colour, typeSize, x * 0.37648785, y, delay * 13, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "R", colour, typeSize, x * 0.4679586, y, delay * 14, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "T", colour, typeSize, x * 0.55133635, y, delay * 15, duration, fontLight, AnimationType.SlideLeftRight, false ) );
  type.add( new TypeAtom( "Y", colour, typeSize, x * 0.6320402, y, delay * 16, duration, fontLight, AnimationType.SlideLeftRight, false ) );

  animation.beginSequence();
  animation.beginStep();
  for ( TypeAtom atom : type ) {
    atom.addForward();
  }

  // Line
  animation.add( Ani.to( this, duration, delay * 18, "lineWidth", 9.075, Ani.EXPO_OUT ) );
  animation.endStep();

  // Pause
  animation.beginStep();
  animation.add( Ani.to( this, 10.0, 0, "pause", 100, Ani.EXPO_IN ) );
  animation.endStep();

  // Reverse
  animation.beginStep();
  for ( TypeAtom atom : type ) {
    atom.addReverse();
  }
  animation.add( Ani.to( this, duration, delay * 18, "lineWidth", 0, Ani.EXPO_IN ) );
  animation.endStep();

  // Final pause
  animation.beginStep();
  animation.add( Ani.to( this, 10.0, 0, "pause", 0, Ani.EXPO_IN, "onEnd:onEnd" ) );
  animation.endStep();

  animation.endSequence();
  animation.start();
}

void onEnd() {
  pause = 0;

  for ( TypeAtom atom : type ) {
    switch( atom.type ) {
      case SlideLeftRight:
        atom.x -= atom.size * 2;
        break;
      default:
        break;
    }
  }

  animation.start();
}

void addBlob() {
  int type = int( random( colours.length ) );

  blobs.add(
    new Blob(
      random( width ),
      random( height ),
      random( blobMinSize, blobMaxSize ),
      colours[ type ],
      type
    )
  );
}

void removeDeadBlobs() {
  int size = blobs.size ();
  for ( int x = size - 1; x >= 0; x-- ) {
    Blob blob = ( Blob )blobs.get( x );

    if ( blob.isDead() ) {
      blobs.set( x, blobs.get( blobs.size () - 1 ) );
      blobs.remove( blobs.size () - 1 );
    }
  }

  for ( int x = size ; x < blobCount ; x++ ) {
    addBlob();
  }
}

void drawBlobs() {
  removeDeadBlobs();

  pgl.enable( PGL.TEXTURE_2D );
  pgl.depthMask( false );
  pgl.enable( PGL.BLEND );
  pgl.blendFuncSeparate( PGL.SRC_ALPHA, PGL.ONE_MINUS_SRC_ALPHA, PGL.ONE, PGL.ONE );

  for ( Blob blob : blobs ) {
    int colour = blob.type == colours.length-1 ? colours[0] : colours[blob.type+1];
    blob.setPosition();
    blob.setAlpha();
    blob.setLerpColour(colour);
    blob.draw( img );
  }
}

void drawLogo() {
  float w = width * logoWidth;
  float h = w / logoRatio;

  translate( -w * .475, -h * .13 );
  for ( int x = 0 ; x < type.size() ; x++ ) {
    type.get(x).draw();
  }

  float ratio = lineWidth == 0 ? 0 : lineWidth/100;
  float x = w * .4757 - ((w * ratio) / 2);
  float y = h * .5967;

  noStroke();
  fill(0xffffffff);
  rect(x, y, w * ratio, h * .03957);

  pgl.disable( PGL.TEXTURE_2D );
}
