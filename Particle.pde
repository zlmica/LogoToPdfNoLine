import java.util.Iterator;  
import java.util.LinkedList;

float attForce = 0.003;
float repForce = 0.005;
float r;

class Particle {
  int id = 0;
  PVector pos = new PVector();
  PVector oriPos = this.pos.copy();
  PVector target = this.pos.copy();
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  //color pColor;
  //color lineColor;
  //LinkedList<PVector> tails = new LinkedList<PVector>();
  PVector lastPos = this.pos.copy();
  float sizeFactor;
  float size;
  float targetSize;
  int lifeTime;
  Particle next;
  
  Particle(int _id,int _x, int _y) {
    this.id = _id;
    this.pos = new PVector(_x, _y);
    //this.lineColor = this.pColor = img.pixels[_y*img.width+_x];
    this.pos.x+=(width - img.width)/2;
    this.oriPos = this.pos.copy();
    this.target = this.pos.copy();
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.sizeFactor = 1;//random(1.0/4.0,4.0);
    this.size = 10;
    this.lifeTime = int(random(pointLife/2.0,pointLife*1.5));
  }
  
  void move() {
    this.lastPos = this.pos.copy();
    this.targetSize = pointSize;
    
    if(!unlimitedLife){
      if(this.lifeTime--<0){
        this.pos.x=this.oriPos.x;
        this.pos.y=this.oriPos.y;
        this.lifeTime=int(random(pointLife-5,pointLife+5));
      } else {
        if(sizeChangeOverLife) this.targetSize*=float(this.lifeTime)/float(pointLife);
      }
    }
    
    if(this.oriPos.x>staticWidth) {
      this.pos.x = this.oriPos.x;
      this.pos.y = this.oriPos.y;
      this.size = pointSize;
      return;
    }
    
    PVector logoDist = PVector.sub(this.oriPos, this.pos).mult(logoStrength);
    PVector waveDist = PVector.sub(calculateWavePos(),this.oriPos).mult(waveStrength);
    PVector circleDist = PVector.sub(calculateCirclePos(),this.oriPos).mult(circleStrength);
    PVector repulseDist = PVector.sub(calculateRepulseDistPos(),this.oriPos).mult(repulseStrength);
    PVector lissajousDist = PVector.sub(calculateLissajousPos(),this.oriPos).mult(lissajousStrength);
    
    float noiseValue = noise(this.pos.x * noiseFactor/30.0, this.pos.y * noiseFactor/30.0,noiseChange);
    PVector noiseVector = PVector.fromAngle(noiseValue*TWO_PI/*+PI*deadCount*/).mult(noiseStrength).rotate(TWO_PI*noiseDirection);
    
    //float n = map(noise(this.pos.x * (noiseFactor/30), this.pos.y * (noiseFactor/30),frameCount/100.0), 0, 1, -noiseStrength, noiseStrength);
    //PVector noiseVector = new PVector(this.oriPos.x-width/2,this.oriPos.y-height/2).normalize().mult(-n).rotate(TWO_PI*noiseDirection);

    
    this.acc = PVector.add(PVector.add(PVector.add(PVector.add(logoDist,waveDist),circleDist),repulseDist),lissajousDist).add(noiseVector);



    this.vel.mult(0.5).add(this.acc).limit(pointSpeed);
    this.pos.add(this.vel);
    this.size = this.targetSize;
    //this.pos.add(noiseVector); 
    if(this.pos.x<0||this.pos.x>width||this.pos.y<0||this.pos.y>height){
      //this.lastPos.x = this.pos.x = this.oriPos.x;
      //this.lastPos.y = this.pos.y = this.oriPos.y;
      
    }
    
  }
  
  void display() {
    pushStyle();
    fill(pointColor/*this.pColor,150*/);
    noStroke();
    if(showPoint) ellipse(this.pos.x, this.pos.y,this.size,this.size);
    popStyle();
    
    
    
  }
  
  PVector calculateCirclePos(){
    PVector mouseVector = PVector.sub(this.oriPos,new PVector(mouseX,mouseY));
    float mouseDist = mouseVector.mag();
    float mouseAngle = map(mouseDist,0,circleRadius,0,PI);
    mouseVector.normalize();
    
    if(mouseDist<circleRadius){
      this.targetSize = this.targetSize*map(circleStrength,0,1,1,abs(cos(mouseAngle/2))*2);
      mouseVector.mult(circleStrength*500*sin(mouseAngle));
    }
    return new PVector( this.oriPos.x+mouseVector.x , this.oriPos.y+mouseVector.y);
  }
  
  PVector calculateRepulseDistPos(){
    PVector desired = PVector.sub(new PVector(mouseX,mouseY), this.pos);
    float d = desired.mag();
    
    desired.setMag(-100);
    return d>repulseRange ? this.oriPos : PVector.add(desired,this.oriPos);
  }
  
  PVector calculateWavePos(){
    float t = (float)frameCount/100;
    float theta = TWO_PI*t;
    float offSet = waveFactorX*this.oriPos.x+waveFactorY*this.oriPos.y;
    
    this.targetSize = this.targetSize - waveStrength * map(sin(-theta+offSet), 0, 1, pointDensity*(0.5-waveStrength/2), pointDensity*(0.5+waveStrength/2)); // map size off the ellipse
    
    return new PVector(this.oriPos.x+cos(-theta+offSet)*waveWidth,this.oriPos.y-cos(-theta+offSet)*waveHeight+sin(this.oriPos.x/width*waveMoveFactor+(float)frameCount/100)*height/4*waveMoveRange);
  }
  
  PVector calculateLissajousPos(){
    float angle = new PVector(this.oriPos.x-width/2,this.oriPos.y-height/2).heading();
    float lissajousWidth = min(width,height)/2;
    lissajousWidth = lissajousWidth>200?lissajousWidth:lissajousWidth - 100;
    float x = sin(angle*lissajousXFreq+radians(lissajousPhase)+frameCount/100.0)*lissajousWidth*0.85+width/2;
    float y = sin(angle*lissajousYFreq+frameCount/100.0)*lissajousWidth*0.85+height/2;
    return new PVector(x , y);
  }
  
}
