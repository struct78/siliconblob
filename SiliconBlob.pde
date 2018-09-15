import toxi.geom.*;

PGL pgl;
ArrayList<Blob> blobs;
PImage img;
PImage logo;

int[] colours;
int blobCount;
int blobMaxSize;
float logoRatio = 3.195020746887967;
float logoWidth = .4;

void settings() {
  fullScreen(P3D);
}

void setup() {
  setupBlobs();
}

void draw() {
  translate( width / 2, height / 2 );
  background( 0 );
  drawBlobs();
  drawLogo();
}

void setupBlobs() {
  pgl = ((PGraphicsOpenGL) g).pgl;
  blobCount = 40;
  blobMaxSize = 2300;
  blobs = new ArrayList<Blob>();
  img = loadImage( "reflection.png" );
  logo = loadImage( "logo.png" );
  colours = new int[] {
    0xff588ffc,
    0xff382054,
    0xffa04cff,
    0xff522651,
    0xffd545e6,
    0xff7458fc,
    0xffbb45e6,
    0xffcda1ff,
    0xffd9d9d9
  };

  for ( int x = 0 ; x < blobCount ; x++ ) {
    addBlob( x );
  }
}

void addBlob( int index ) {
  int type = int( random( colours.length ) );

  blobs.add(
    new Blob(
      index,
      random( width ),
      random( height ),
      random( blobMaxSize/2, blobMaxSize ),
      colours[ type ], type
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
    addBlob( size+x );
  }
}

void drawBlobs() {
  removeDeadBlobs();
  pgl.enable( PGL.TEXTURE_2D );
  pgl.depthMask( false );
  pgl.enable( PGL.BLEND );
  pgl.blendFuncSeparate( PGL.SRC_ALPHA, PGL.ONE_MINUS_SRC_ALPHA, PGL.ONE, PGL.ONE );

  for ( Blob blob : blobs ) {
    blob.setPosition();
    blob.setAlpha();
    blob.draw( img );
  }
}

void drawLogo() {
  imageMode( CENTER );
  image( logo, 0, 0, width * logoWidth, width * logoWidth / logoRatio );

  pgl.disable( PGL.TEXTURE_2D );
}
