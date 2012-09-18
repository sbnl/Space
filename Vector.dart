//Copyright Software By Numbers Ltd

#library("sbnl:space");
#import('SimpleVector2D.dart');
#import('Direction.dart');

/**
 * Defines a vector (magnitude and direction) in 2d
 */
abstract class Vector2D  {

  abstract Direction getDirection(); // throws Vector2dException;
  abstract double getMagnitude(); // throwsVector2DException;
  abstract String asString(String f(Vector2D vector));
}

class  Vector2dException implements Exception {
}


