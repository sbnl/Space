//Copyright Software By Numbers Ltd
#library('sbnl:space');
/**
 * Class defines a 2D point in space.
 */
interface Point2D {
  String asString(String f(int x, int y, [int z]));
  num magnitude();   //throws PointException
  num get x();
  num get y();
  set x(num x);
  set y(num y);
}

/**
 * Class defines a 3D point in space.
 */
interface Point3D extends Point2D {
  String toString();
}

interface PointException extends Exception {}






