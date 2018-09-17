class Blob {
  float x;
  float y;
  float radius;
  float alpha;
  float div;
  float speed;
  float delta;
  float theta;
  int colour;
  int maxAlpha;
  int type;
  Vec3D pos;
  Vec3D start;
  Vec3D vel;

  Blob( float x, float y, float radius, int colour, int type ) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.colour = colour;
    this.type = type;
    this.div = 10;
    this.speed = 1.5;
    this.delta = 1.5;
    this.alpha = 0;
    this.maxAlpha = 255;
    this.theta = random( 0.002, 0.004 );
    this.theta = random( 1 ) > 0.5 ? -this.theta : this.theta;
    this.pos = new Vec3D( random( -width, width ), random( -height, height ), 0 );
    this.start = this.pos.copy();

    float xVec = random( this.speed / 2, this.speed );
    float yVec = random( this.speed / 2, this.speed );
    xVec = random( 1 ) > 0.5 ? xVec : -xVec;
    yVec = random( 1 ) > 0.5 ? yVec : -yVec;
    this.vel = new Vec3D( xVec, yVec, 0 );
  }

  boolean isDead() {
    return abs( this.pos.x ) > width + ( this.radius * 2 ) || abs(this.pos.y) > height + ( this.radius * 2 );
  }

  void setPosition() {
    this.pos.addSelf( this.vel );
    this.pos.rotateZ( this.theta );
  }

  void setAlpha() {
    if ( this.alpha + this.delta < maxAlpha ) {
      this.alpha += this.delta;
    } else {
      this.alpha = maxAlpha;
    }
  }

  void draw( PImage img ) {
    pushMatrix();
    translate( this.pos.x, this.pos.y, this.pos.z );
    tint( red( this.colour ), green( this.colour ), blue( this.colour ), this.alpha );
    imageMode( CENTER );
    image( img, 0, 0, this.radius * 2, this.radius * 2 );
    noTint();
    popMatrix();
  }
}
