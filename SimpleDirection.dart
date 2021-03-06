//Copyright Software By Numbers Ltd

#library('sbnl:space');
#import('Direction.dart');
#import('Point.dart');
#import('dart:math');

class SimpleDirection implements Direction {

  final num ONE_DEG = 0.0174532925; //One dedree in rads
  final num ONE_RAD = 57.2957795;   //One rad in degrees

  num _deg = 0.00;
  num _rad = 0.00;

  SimpleDirection.fromDegs(num degs) {
    _deg = degs;
    _rad = degsToRads(_deg);
  }

  SimpleDirection.fromRads(num rads) {
    _rad = rads;
    _deg = radsToDegs(_rad);
  }

  SimpleDirection.fromPoint(Point2D point) {
    var x = point.x;
    var y = point.y;

    //we need to find the quadrant and the edge conditions
    if (x==0){_rad = 0.0; _deg = 0.0;}
    else if ((x==0)&&(y==0)) {_rad = 0.0; _deg=0.0;}
    else if ((x>0)&&(y<0.000001) && (y>=0.0)){_rad = PI/2; _deg = 90.0;}
    else if ((x>0)&&(y>0)){_rad = atan(x/y); _deg = radsToDegs(_rad);}
    else if ((x>0)&&(y<0)){_rad = atan(x/-y) + PI/2;_deg = radsToDegs(_rad);}
    else if ((x<0)&&(y<0)){_rad=atan(-x/-y) + PI;_deg = radsToDegs(_rad);}
    else if ((x<0)&&(y>0)){_rad=atan(-x/y) + PI * 3/2;_deg = radsToDegs(_rad);}
  }

  //Direction in degrees is 0 to 359.99 degrees.
  num getDegrees() {
    return _deg;
  }

  //Direction in radians is 0.01 to 2 pi
  num getRadians() {
    return _rad;
  }

  String asString(String f(Direction direction)) {
    return f(this);
  }

  num degsToRads(num deg) {
    return deg * ONE_DEG;
  }

  num radsToDegs(num rad) {
    return rad * ONE_RAD;
  }


}
