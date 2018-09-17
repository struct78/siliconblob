import toxi.geom.*;

PGL pgl;
ArrayList<Blob> blobs;
PImage img;
PImage logo;

float logoRatio = 3.195020746887967;
float logoWidth = .4;

int blobCount = 40;
int blobMinSize = 1440;
int blobMaxSize = 2250;

int[] colours = new int[] {
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

void settings() {
  fullScreen( P3D );
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
  blobs = new ArrayList<Blob>();
  img = loadImage( "gradient.png" );
  logo = loadImage( "logo.png" );

  for ( int x = 0 ; x < blobCount ; x++ ) {
    addBlob();
  }
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
