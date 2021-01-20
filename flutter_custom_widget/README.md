
#### Canvas 方法一览 :

---->[画布状态]----
void save()
void saveLayer(Rect bounds, Paint paint)
void restore()
int getSaveCount()

---->[画布变换]----
void skew(double sx, double sy)
void rotate(double radians)
void scale(double sx, [double sy])
void translate(double dx, double dy)
void transform(Float64List matrix4)

---->[画布裁剪]----
void clipRect(Rect rect, { ClipOp clipOp = ClipOp.intersect, bool doAntiAlias = true })
void clipRRect(RRect rrect, {bool doAntiAlias = true})
void clipPath(Path path, {bool doAntiAlias = true})

---->[画布绘制--点相关]----
void drawPoints(PointMode pointMode, List<Offset> points, Paint paint)
void drawRawPoints(PointMode pointMode, Float32List points, Paint paint)
void drawLine(Offset p1, Offset p2, Paint paint)
void drawVertices(Vertices vertices, BlendMode blendMode, Paint paint)

---->[画布绘制--矩形相关]----
void drawRect(Rect rect, Paint paint)
void drawRRect(RRect rrect, Paint paint)
void drawDRRect(RRect outer, RRect inner, Paint paint)

---->[画布绘制--类圆相关]----
void drawOval(Rect rect, Paint paint)
void drawCircle(Offset c, double radius, Paint paint)
void drawArc(Rect rect, double startAngle, double sweepAngle, bool useCenter, Paint paint)

---->[画布绘制--图片相关]----
void drawImage(Image image, Offset p, Paint paint)
void drawImageRect(Image image, Rect src, Rect dst, Paint paint)
void drawImageNine(Image image, Rect center, Rect dst, Paint paint)
void drawAtlas(Image atlas,List<RSTransform> transforms,List<Rect> rects,List<Color> colors,BlendMode blendMode,Rect cullRect,Paint paint)
void drawRawAtlas(Image atlas,Float32List rstTransforms,Float32List rects,Int32List colors,BlendMode blendMode,Rect cullRect,Paint paint)

---->[画布绘制--文字]----
void drawParagraph(Paragraph paragraph, Offset offset)

---->[画布绘制--其他]----
void drawColor(Color color, BlendMode blendMode)
void drawPath(Path path, Paint paint)
void drawPaint(Paint paint)
void drawShadow(Path path, Color color, double elevation, bool transparentOccluder)
void drawPicture(Picture picture)

#### Paint 属性一览 :

isAntiAlias(抗锯齿) color(颜色)          blendMode(混合模式)     style(画笔样式)
strokeWidth(线宽)   strokeCap(线帽类型)  strokeJoin(线接类型)    strokeMiterLimit(斜接限制)
maskFilter(遮罩滤镜) shader(着色器)      colorFilter(颜色滤镜)    imageFilter(图片滤镜)
invertColors(是否反色)                  filterQuality(滤镜质量)

#### Path 方法一览 :

---->[路径绝对移动]----
void moveTo(double x, double y)
void lineTo(double x, double y)
void quadraticBezierTo(double x1, double y1, double x2, double y2)
void cubicTo(double x1, double y1, double x2, double y2, double x3, double y3)
void conicTo(double x1, double y1, double x2, double y2, double w)
void arcTo(Rect rect, double startAngle, double sweepAngle, bool forceMoveTo)
void arcToPoint(Offset arcEnd, {Radius radius = Radius.zero, double rotation = 0.0, bool largeArc = false, bool clockwise = true,})

---->[路径相对移动]----
void relativeMoveTo(double dx, double dy)
void relativeLineTo(double dx, double dy)
void relativeQuadraticBezierTo(double x1, double y1, double x2, double y2)
void relativeCubicTo(double x1, double y1, double x2, double y2, double x3, double y3)
void relativeConicTo(double x1, double y1, double x2, double y2, double w)
void relativeArcToPoint(Offset arcEndDelta, { Radius radius = Radius.zero, double rotation = 0.0, bool largeArc = false, bool clockwise = true, })

---->[路径添加]----
void addRect(Rect rect)
void addRRect(RRect rrect)
void addOval(Rect oval)
void addArc(Rect oval, double startAngle, double sweepAngle)
void addPolygon(List<Offset> points, bool close)
void addPath(Path path, Offset offset, {Float64List matrix4})
void extendWithPath(Path path, Offset offset, {Float64List matrix4})

---->[路径操作]----
void close()
void reset()
bool contains(Offset point)
Path shift(Offset offset)
Path transform(Float64List matrix4)
Rect getBounds()
set fillType(PathFillType value)
static Path combine(PathOperation operation, Path path1, Path path2)
PathMetrics computeMetrics({bool forceClosed = false})