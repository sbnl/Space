//Copyright Software By Numbers Ltd
#library('sbnl:space');
#import('Vector.dart');
#import('Direction.dart');
#import('SimpleDirection.dart');
#import('Point.dart');
/**
 * Describes a simple default implementation of a vector.
 */
class SimpleVector2D implements Vector2D {

  Direction _direction;
  double _mag = 0.0;

  SimpleVector2D.fromPoint(Point2D point) {
    _direction = new SimpleDirection.fromPoint(point);
  }

  SimpleVector2D.fromMagAndDir(double mag, Direction direction) {
    _mag = mag;
    _direction = direction;
  }

  Direction getDirection() {
    return  _direction;
  }

  double getMagnitude() {
    return _mag;
  }

  String asString(String f(Vector2D vector2D)) {
    return f(this);
  }

}
