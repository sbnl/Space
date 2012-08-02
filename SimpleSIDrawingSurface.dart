//Copyright Software By Numbers Ltd

#library('sbnl:space');
#import('dart:html');
#import('Point.dart');
#import('SISurface.dart');
#import('SimplePoint.dart');


/**
 * A simple implementation of the SI DFrawing surface.
 */
class SimpleSIDrawingSurface implements SIDrawingSurface {

  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  int _width;
  int _height;

  ScaleUnitsToPixels _scaleXUnitsToPixels;
  ScaleUnitsToPixels _scaleYUnitsToPixels;
  ScaleUnitsToPixels _scaleXPixelsToUnits;
  ScaleUnitsToPixels _scaleYPixelsToUnits;


  //This is the buffer area around the space
  static final int buffer = 60;

  SimpleSIDrawingSurface.fromCanvas(CanvasElement canvas) {
    this._canvas = canvas;
    this._ctx = canvas.getContext("2d");
    this._width = canvas.width;
    this._height = canvas.height;
  }

  void setScaleUnitsToPixels(ScaleUnitsToPixels scaleXUnitsToPixels, ScaleUnitsToPixels scaleYUnitsToPixels) {
    this._scaleXUnitsToPixels = scaleXUnitsToPixels;
    this._scaleYUnitsToPixels = scaleYUnitsToPixels;
  }

  void setScalePixelsToUnits(ScalePixelsToUnits scaleXPixelsToUnits, ScalePixelsToUnits scaleYPixelsToUnits) {
    this._scaleXPixelsToUnits = scaleXPixelsToUnits;
    this._scaleYPixelsToUnits = scaleYPixelsToUnits;
  }



  /**
   * Draws straight line between the two points using the suppied functors to
   * scale in x and y.
   */
  void drawLine(Point2D point1, Point2D point2) {
    if (!_ready()) {
      throw new SimpleSIDrawingSurfaceException();
    }
    //find the origin
    int x1 = this._scaleXUnitsToPixels(point1.x) + buffer;
    int y1 = this._height - this._scaleYUnitsToPixels(point1.y) - buffer;
    int x2 = this._scaleXUnitsToPixels(point2.x) + buffer;
    int y2 = this._height - this._scaleYUnitsToPixels(point2.y) - buffer;
    _drawPixelLine(x1,y1,x2,y2);
  }

  void eraseLine(Point2D point1, Point2D point2) {
    if (!_ready()) {
      throw new SimpleSIDrawingSurfaceException();
    }
    //find the origin
    int x1 = adjustTopLeftBuffer(this._scaleXUnitsToPixels(point1.x));
    int y1 = this._height - this._scaleYUnitsToPixels(point1.y);
    int x2 = adjustTopLeftBuffer(this._scaleXUnitsToPixels(point2.x));
    int y2 = this._height - this._scaleYUnitsToPixels(point2.y);
    _ctx.setCompositeOperation('xor');
    _ctx.beginPath();
    _ctx.moveTo(x1, y1);
    _ctx.lineTo(x2, y2);
    _ctx.stroke();
  }

  void _drawPixelLine(int x1, int y1, int x2, int y2) {
    _ctx.setCompositeOperation('');
    _ctx.beginPath();
    _ctx.moveTo(x1, y1);
    _ctx.lineTo(x2, y2);
    _ctx.stroke();
  }



  /**
   *
   */
  void drawXAxis(Point2D origin, num graticuleInterval, num startValue,[String units = "s"]) {

    if (!_ready()) {
      throw new SimpleSIDrawingSurfaceException();
    }

    //find the origin
    int x1 = buffer + this._scaleXUnitsToPixels(origin.x);
    int y1 = this._height - this._scaleYUnitsToPixels(origin.y) - buffer;
    int x2 = this._width - buffer;
    int y2 = y1;
    _drawPixelLine(x1,y1,x2,y2);
    //the graticules
    double graticuleNumber = 0.0;
    for (int i = 0;i<this._width;i+=this._scaleXUnitsToPixels(graticuleInterval)) {
      drawGraticuleMark(x1+i,y1,10,true);
      drawScaleDigits(this._ctx, x1 + i, y1, 1,graticuleNumber,units, false);
      graticuleNumber += 1.0;
    }
  }

 /**
  *
  */
 void drawYAxis(Point2D origin, num graticuleInterval, num startValue,[String units = "m"])  {
   if (!_ready()) {
     throw new SimpleSIDrawingSurfaceException();
   }
   //find the origin
   int x1 = buffer + this._scaleXUnitsToPixels(origin.x);
   int y1 = this._height - this._scaleYUnitsToPixels(origin.y) - buffer;
   int x2 = x1;
   int y2 = buffer;
   _drawPixelLine(x1,y1,x2,y2);
   //the graticules
   double graticuleNumber = 0.0;
   for (int i = 0;i<this._height-buffer;i+=this._scaleYUnitsToPixels(graticuleInterval)) {
     drawGraticuleMark(x1,y1 - i,10,false);
     drawScaleDigits(this._ctx, x1, y1-i, 1,graticuleNumber,units, true);
     graticuleNumber += 1.0;
   }
 }

//Draws a little graticule mark determined by the horizontal flag
void drawGraticuleMark(int x, int y , int pixels, [bool horizontal = true]) {
  if (horizontal) {
    _drawPixelLine(x, (y-(pixels/2)).toInt(),x, (y+(pixels/2)).toInt());
  } else {;
    _drawPixelLine((x-(pixels/2)).toInt(),y,(x+(pixels/2)).toInt(), y);
  }
}

void drawScaleDigits(CanvasRenderingContext2D ctx ,int x, int y, int decPlaces, double num, String unit, [bool left = true]) {
  //just assume a font for now
  ctx.font = "italic 8pt Calibri"; //style sheets?
  if (left) {
    ctx.fillText("${num}${unit}",x-40,y);
  } else {
    ctx.fillText("${num}${unit}",x,y+40);
  }
}

  void drawOutline([bool yes = true]) {
    _ctx.beginPath();
    _ctx.moveTo(0,0);
    _ctx.lineTo(_width, 0);
    _ctx.stroke();
    _ctx.lineTo(_width, _height);
    _ctx.stroke();
    _ctx.lineTo(0, _height);
    _ctx.stroke();
    _ctx.lineTo(0, 0);
    _ctx.stroke();
  }


  //Thse adust x or y for the buffer zone around the surface.
  int adjustTopLeftBuffer(int pix) {
    return pix + buffer;
  }
  int adjustBottomRight(int pix) {
    return buffer - pix;
  }

  Point2D adjustUnitPoint(Point2D point) {
    Point2D adjustedPoint = new SimplePoint.empty();
    adjustedPoint.x = this._scaleXPixelsToUnits((adjustTopLeftBuffer(this._scaleXUnitsToPixels(point.x))));
    adjustedPoint.y = this._scaleYPixelsToUnits((adjustTopLeftBuffer(this._scaleYUnitsToPixels(point.y))));
    return point;
  }

  bool _ready() {
    return((_scaleXUnitsToPixels != null) && (_scaleYUnitsToPixels != null) && (_scaleXPixelsToUnits != null) && (_scaleYPixelsToUnits != null));
  }

}


class SimpleSIDrawingSurfaceException implements SIDrawingSurfaceException {

}


