//Copyright Software By Numbers Ltd
#library('sbnl:space');
/**
 * Class defines a 2D point in space.
 */
abstract class  Point2D {
  abstract String asString(String f(int x, int y, [int z]));
  abstract num magnitude();   //throws PointException
  abstract num get x();
  abstract num get y();
  abstract set x(num x);
  abstract set y(num y);
}

/**
 * Class defines a 3D point in space.
 */
abstract class Point3D extends Point2D {
  abstract String toString();
}

class PointException implements Exception {}






