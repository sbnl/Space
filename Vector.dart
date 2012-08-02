//Copyright Software By Numbers Ltd

#library("sbnl:space");
#import('SimpleVector2D.dart');

/**
 * Defines a vector (magnitude and direction) in 2d
 */
interface Vector2D  {

  Direction getDirection(); // throws Vector2dException;
  double getMagnitude(); // throwsVector2DException;
  String asString(String f(Vector2D vector));
}

interface Vector2dException extends Exception {
}


