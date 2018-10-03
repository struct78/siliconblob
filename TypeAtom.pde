class TypeAtom {
  boolean isAnimating;
  boolean isFinished;
  float delay;
  float size;
  float rotation;
  int colour;
  float duration;
  float alpha;
  float x;
  float y;
  float motionDistance;
  AnimationType type;
  boolean isEndOfSequence;
  String character;
  PFont font;

  TypeAtom( String character, int colour, float size, float x, float y, float delay, float duration, PFont font, AnimationType type, boolean isEndOfSequence ) {
    this.character = character;
    this.colour = colour;
    this.alpha = 0;
    this.rotation = 90;
    this.size = size;
    this.x = x;
    this.y = y;
    this.delay = delay;
    this.isAnimating = false;
    this.isFinished = false;
    this.duration = duration;
    this.motionDistance = .25;
    this.font = font;
    this.isEndOfSequence = isEndOfSequence;
    this.type = type;
  }

  void addForward() {
    switch( this.type ) {
      case SlideLeftRight:
        this.x = this.x - (this.size * this.motionDistance);
        animation.add( Ani.to( this, this.duration, this.delay, "x", this.x + (this.size * this.motionDistance), Ani.EXPO_OUT ) );
        animation.add( Ani.to( this, this.duration, this.delay, "alpha", 255, Ani.EXPO_OUT ) );
        animation.add( Ani.to( this, this.duration, this.delay, "rotation", 0, Ani.EXPO_OUT ) );
        break;
      case FadeIn:
        animation.add( Ani.to( this, this.duration, this.delay, "alpha", 70, Ani.EXPO_OUT ) );
        break;
      default:
        break;
    }
  }

  void addReverse() {
    switch( this.type ) {
      case SlideLeftRight:
        animation.add( Ani.to( this, this.duration, this.delay, "x", this.x + (this.size * this.motionDistance), Ani.EXPO_OUT ) );
        animation.add( Ani.to( this, this.duration, this.delay, "alpha", 0, Ani.EXPO_OUT ) );
        animation.add( Ani.to( this, this.duration, this.delay, "rotation", 0, Ani.EXPO_OUT ) );
        break;
      case FadeIn:
        animation.add( Ani.to( this, this.duration, this.delay, "alpha", 0, Ani.EXPO_OUT, "onEnd:onEnd" ) );
        break;
      default:
        break;
    }
  }
  
  void setX( float x ) {
    this.x = x;
  }

  void draw() {
    pushMatrix();
    textFont( this.font );
    textSize( this.size );
    textAlign( CENTER );
    fill( this.colour, this.alpha );
    text( this.character, this.x, this.y );
    popMatrix();

    if (!this.isAnimating) {
      this.isAnimating = true;
    }
  }
}
