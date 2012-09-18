//Copyright Software By Numbers Ltd
#library('sbnl:space');
#import('Point.dart');
#import('dart:math');

/**
 * Implements a point in 2d space.
 */
class SimplePoint implements Point2D {

   num _x,_y;

   SimplePoint.empty();

   SimplePoint(this._x,this._y);

   String toString() => "x =  ${x.toString()}  and y =  ${y.toString()}";

   String asString(String f(int x, int y, [int z])) => f(_x,_y);

   num magnitude() => sqrt(x*x + y*y);

   num get x() => _x;

   num get y() => _y;

   void set x(num x) {this._x = x;}
   void set y(num y) {this._y = y;}
}


class Simple3dPoint extends SimplePoint implements Point3D {

  num _z;

  Simple3dPoint(x,y,this._z): super(x,y);  //dont understand this...

  String asString(String f(int x, int y, [int z])) => f(x,y,_z);

  String toString() => "${super.toString()} and z = + ${_z}";

}

class PointMagnitudeException implements PointException {

}



