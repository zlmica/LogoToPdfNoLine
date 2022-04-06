import controlP5.*;
ControlP5 cp5;

int minX=10000;
int minY=10000;
int maxX=0;
int maxY=0;

int pointDensity = 16;
float staticWidth;

boolean pause = false;
boolean showPoint = true;
float pointSize = pointDensity/2;
float attractorStrength = 1.0;
float logoStrength = 1.0;
float repulseStrength = 0.0;
float repulseRange = 50.0;
float noiseStrength = 0.0;
float noiseFactor = 0.06;
float noiseChange = 0.0;
float noiseDirection = 0;
float circleStrength = 0;
float circleRadius=100;
float waveStrength = 0;
float waveHeight = 0;
float waveWidth = 0;
float waveFactorX = 10;
float waveFactorY = 20;
float waveMoveRange = 0;
float waveMoveFactor = 30;

int lissajousXFreq=1;
int lissajousYFreq=1;
int lissajousPhase=90;
float lissajousStrength=0;

int pointColor = color(0);
int backgroundColor = color(255);
boolean unlimitedLife = true;
boolean sizeChangeOverLife = true;
int pointLife = 10;
float pointSpeed = 5.0;

void initUI()
{
  staticWidth = width;  
  
  int itemWidth = 200;
  int itemHeight = 20;
  int itemTopMargin = 10;
  int itemLeftMargin = 10;
  int groupMargin = 15;
  int groupWidth = 330;
  int leftPositionX = 10;
  int rightPositionX = width - 340;
  int nowGroupHeight = 0;
  int nowItemHeight;
  color backgroundColor = color(0,0,0);
  color labelColor = color(30,0,198);
  color labelFontColor = color(255,255,255);
  color sliderBackgroundColor = color(30,0,198);
  color sliderForegroundColor = color(55,231,128);
  color sliderValueColor = color(0,0,0);
  color sliderTextColor = color(55,231,128);
  
  Group logoGroup = cp5.addGroup("logoGroup")
                       .setPosition(leftPositionX,nowGroupHeight+=groupMargin)
                       .setSize(groupWidth,(itemHeight+itemTopMargin)*2+itemTopMargin)
                       .setBackgroundColor(backgroundColor)
                       .setColorLabel(labelFontColor)
                       .setColorForeground(labelColor)
                       .setColorBackground(labelColor)
                       .setLabel("Logo  Group");
  nowItemHeight = 0;
  cp5.addSlider("logoStrength", 0.0, 1.0, logoStrength, itemLeftMargin, nowItemHeight+=itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor)
  .setColorForeground(sliderForegroundColor)
  .setColorBackground(sliderBackgroundColor)
  .setColorActive(sliderForegroundColor)
  .setColorValue(sliderValueColor)
  .setLabel("Logo    Strength")
  .setGroup(logoGroup);
  cp5.addSlider("staticWidth", 0.0, width, width, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor)
  .setColorForeground(sliderForegroundColor)
  .setColorBackground(sliderBackgroundColor)
  .setColorActive(sliderForegroundColor)
  .setColorValue(sliderValueColor)
  .setLabel("Stay    Still")
  .setGroup(logoGroup);
  nowGroupHeight += nowItemHeight+itemHeight+groupMargin;
  
  Group repulseGroup = cp5.addGroup("repulseGroup")
                       .setPosition(leftPositionX,nowGroupHeight+=groupMargin)
                       .setSize(groupWidth,(itemHeight+itemTopMargin)*2+itemTopMargin)
                       .setBackgroundColor(backgroundColor).setColorLabel(labelFontColor).setColorForeground(labelColor).setColorBackground(labelColor)
                       .setLabel("repulse  Group");
  nowItemHeight = 0;
  cp5.addSlider("repulseStrength", 0.0, 1.0, repulseStrength, itemLeftMargin, nowItemHeight+=itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor)
  .setColorForeground(sliderForegroundColor)
  .setColorBackground(sliderBackgroundColor)
  .setColorActive(sliderForegroundColor)
  .setColorValue(sliderValueColor)
  .setLabel("Repulse    Strength")
  .setGroup(repulseGroup);
  cp5.addSlider("repulseRange", 0.0, height/2.0, repulseRange, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor)
  .setColorForeground(sliderForegroundColor)
  .setColorBackground(sliderBackgroundColor)
  .setColorActive(sliderForegroundColor)
  .setColorValue(sliderValueColor)
  .setLabel("Repulse    Range")
  .setGroup(repulseGroup);
  nowGroupHeight += nowItemHeight+itemHeight+groupMargin;
  
  Group noiseGroup = cp5.addGroup("noiseGroup")
                        .setPosition(leftPositionX,nowGroupHeight+=groupMargin)
                        .setSize(groupWidth,(itemHeight+itemTopMargin)*4+itemTopMargin)
                                               .setBackgroundColor(backgroundColor).setColorLabel(labelFontColor).setColorForeground(labelColor).setColorBackground(labelColor) 
                        .setLabel("Noise  Group");
  nowItemHeight = 0;
  cp5.addSlider("noiseStrength", 0.0, 10.0, noiseStrength, itemLeftMargin, nowItemHeight+=itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength")
  .setGroup(noiseGroup);
  cp5.addSlider("noiseFactor", 0.01, 1, noiseFactor, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Noise    Factor")
  .setGroup(noiseGroup);
  cp5.addSlider("noiseChange", 0, 3, noiseChange, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Noise    Change")
  .setGroup(noiseGroup);
  cp5.addSlider("noiseDirection", 0, 1, noiseDirection, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Noise    Direction")
  .setGroup(noiseGroup);
  nowGroupHeight += nowItemHeight+itemHeight+groupMargin;
  
  Group circleGroup = cp5.addGroup("circleGroup")
                        .setPosition(leftPositionX,nowGroupHeight+=groupMargin)
                        .setSize(groupWidth,(itemHeight+itemTopMargin)*2+itemTopMargin)
                                               .setBackgroundColor(backgroundColor).setColorLabel(labelFontColor).setColorForeground(labelColor).setColorBackground(labelColor) 
                        .setLabel("Circle  Group");
  nowItemHeight = 0;
  cp5.addSlider("circleStrength", 0.0, 1.0, 0.0, itemLeftMargin, nowItemHeight+=itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Circle    Strength")
  .setGroup(circleGroup);
  cp5.addSlider("circleRadius", 50, 500, 100, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Circle    Radius")
  .setGroup(circleGroup);
  nowGroupHeight += nowItemHeight+itemHeight+groupMargin;
  
  Group waveGroup = cp5.addGroup("waveGroup")
                       .setPosition(leftPositionX,nowGroupHeight+=groupMargin)
                       .setSize(groupWidth,(itemHeight+itemTopMargin)*7+itemTopMargin)
                                              .setBackgroundColor(backgroundColor).setColorLabel(labelFontColor).setColorForeground(labelColor).setColorBackground(labelColor) 
                       .setLabel("Wave  Group");
  nowItemHeight = 0;
  cp5.addSlider("waveStrength", 0.0, 1.0, 0.0, itemLeftMargin, nowItemHeight+=itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Wave    Strength")
  .setGroup(waveGroup);
  cp5.addSlider("waveMoveRange", 0, 1, waveMoveRange, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Wave    Move    Range")
  .setGroup(waveGroup);
  cp5.addSlider("waveMoveFactor", 0, 100, waveMoveFactor, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Wave    Move    Factor")
  .setGroup(waveGroup);
  cp5.addSlider("waveWidth", -50, 50, waveWidth, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Wave    Width")
  .setGroup(waveGroup);
  cp5.addSlider("waveHeight", -50, 50, waveHeight, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Wave    Height")
  .setGroup(waveGroup);
  cp5.addSlider("waveFactorX", 1, 100, 10, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Wave    Factor    X")
  .setGroup(waveGroup);
  cp5.addSlider("waveFactorY", 1, 100, 20, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Wave    Factor    Y")
  .setGroup(waveGroup);
  nowGroupHeight += nowItemHeight+itemHeight+groupMargin;
  
  Group lissajousGroup = cp5.addGroup("lissajousGroup")
                       .setPosition(leftPositionX,nowGroupHeight+=groupMargin)
                       .setSize(groupWidth,(itemHeight+itemTopMargin)*4+itemTopMargin)
                                              .setBackgroundColor(backgroundColor).setColorLabel(labelFontColor).setColorForeground(labelColor).setColorBackground(labelColor) 
                       .setLabel("Lissajous  Group");
  nowItemHeight = 0;
  cp5.addSlider("lissajousStrength", 0.0, 1.0, 0.0, itemLeftMargin, nowItemHeight+=itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Lissajous    Strength")
  .setGroup(lissajousGroup);
  cp5.addSlider("lissajousXFreq", 1, 20, 1, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Lissajous    X    Frequency")
  .setGroup(lissajousGroup);
  cp5.addSlider("lissajousYFreq", 1, 20, 1, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Lissajous    Y    Frequency")
  .setGroup(lissajousGroup);
  cp5.addSlider("lissajousPhase", 0, 360, 0, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Lissajous    Phase")
  .setGroup(lissajousGroup);
  nowGroupHeight += nowItemHeight+itemHeight+groupMargin;
  
  nowGroupHeight = 0;
  Group pointAndLineGroup = cp5.addGroup("pointAndLineGroup")
                       .setPosition(rightPositionX,nowGroupHeight+=groupMargin)
                       .setSize(groupWidth,(itemHeight+itemTopMargin)*5+itemTopMargin)
                                              .setBackgroundColor(backgroundColor).setColorLabel(labelFontColor).setColorForeground(labelColor).setColorBackground(labelColor) 
                       .setLabel("Point Group");
  nowItemHeight = 0;
  cp5.addSlider("pointSize", 0.0, 20.0, pointSize, itemLeftMargin, nowItemHeight+=itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Point    Size")
  .setGroup(pointAndLineGroup);
  cp5.addSlider("pointDensity", 4, 64, pointDensity, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Point    Density")
  .setGroup(pointAndLineGroup);
  cp5.addSlider("pointSpeed", 1, 100, pointSpeed, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Point    Speed")
  .setGroup(pointAndLineGroup);
  cp5.addCheckBox("lifeCheckBox").setPosition(itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin).setSize(itemHeight, itemHeight)
              .setItemsPerRow(3)
              .setSpacingColumn(100)
              .setSpacingRow(20)
              .addItem("unlimited    Life", 0)
              .addItem("Size    Change    OverLife", 0)
              .setColorLabel(sliderTextColor)
              .setColorBackground(sliderBackgroundColor)
              .setColorForeground(sliderForegroundColor)
              .setColorActive(sliderForegroundColor)
              .activate(0)
              .setGroup(pointAndLineGroup);
  
  cp5.addSlider("pointLife", 5, 50, pointLife, itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin, itemWidth, itemHeight)
  .setColorCaptionLabel(sliderTextColor).setColorForeground(sliderForegroundColor).setColorBackground(sliderBackgroundColor).setColorActive(sliderForegroundColor).setColorValue(sliderValueColor).setLabel("Noise    Strength") 
  .setLabel("Point    Life")
  .setGroup(pointAndLineGroup);
  nowGroupHeight += nowItemHeight+itemHeight+groupMargin;
  
  Group pointColorGroup = cp5.addGroup("pointColorGroup")
                       .setPosition(rightPositionX,nowGroupHeight+=groupMargin)
                       .setSize(groupWidth,70)
                       .setBackgroundColor(backgroundColor).setColorLabel(labelFontColor).setColorForeground(labelColor).setColorBackground(labelColor) 
                       .setLabel("Point Color");
  cp5.addColorPicker("pointColor")
          .setPosition(10, 10)
          .setColorValue(pointColor)
          .setColorLabel(sliderTextColor)
          .setGroup(pointColorGroup);
  nowGroupHeight += 70+groupMargin;
          
  Group opGroup = cp5.addGroup("opGroup")
                       .setPosition(rightPositionX,nowGroupHeight+=groupMargin)
                       .setSize(groupWidth,240)
                       .setBackgroundColor(backgroundColor).setColorLabel(labelFontColor).setColorForeground(labelColor).setColorBackground(labelColor) 
                       .setLabel("option");
  nowItemHeight = 0;
  cp5.addButton("pause")
          .setPosition(itemLeftMargin, nowItemHeight+=itemTopMargin)
          .setSize(200, itemHeight)
          .setLabel("Pause  ==  (press  space)")
          .setColorActive(sliderTextColor).setColorForeground(sliderTextColor).setColorBackground(labelColor) 
          .setGroup(opGroup);
  cp5.addButton("save")
          .setPosition(itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin)
          .setSize(200, itemHeight)
          .setLabel("save  ==  (press  s)")
          .setColorActive(sliderTextColor).setColorForeground(sliderTextColor).setColorBackground(labelColor) 
          .setGroup(opGroup);
  cp5.addButton("quit")
          .setPosition(itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin)
          .setSize(200, itemHeight)
          .setLabel("quit  ==  (press  q)")
          .setColorActive(sliderTextColor).setColorForeground(sliderTextColor).setColorBackground(labelColor) 
          .setGroup(opGroup);
  cp5.addTextlabel("opStatus")
          .setText("Running")
          .setPosition(itemLeftMargin, nowItemHeight+=itemHeight+itemTopMargin)
          .setColorValue(sliderTextColor)
          .setFont(createFont("Arial",20))
          .setGroup(opGroup);
}

public void pointSize(float theValue) {
  pointSize = theValue;
}

public void pointSpeed(float theValue) {
  pointSpeed = theValue;
}

public void unlimitedLife(boolean theValue) {
  unlimitedLife = theValue;
}

public void sizeChangeOverLife(boolean theValue) {
  sizeChangeOverLife = theValue;
}

public void pointLife(int theValue) {
  pointLife = theValue;
}

public void pointDensity(int theValue) {
  pointDensity = theValue;
  Particle lastParticle = null;
  int id = 0;

  for(int i=minY-pointDensity;i<=maxY+4*pointDensity;i+=pointDensity){
    for(int j=minX-pointDensity;j<=maxX+4*pointDensity;j+=pointDensity){
      float r = brightness(img.pixels[i*img.width+j]);
      if(id<particles.size()){
        if(r==0){
          particles.get(id).oriPos.x = j;
          particles.get(id).oriPos.y = i;
          particles.get(id).oriPos.x += (width - img.width)/2;
          if(lastParticle!=null){
            lastParticle.next = particles.get(id);
            lastParticle = particles.get(id);
          } else {
            lastParticle = particles.get(id);
          }
          id++;
        } else {
          if(lastParticle!=null) lastParticle.next = null;
          lastParticle = null;
        }
      } else {
        if(r==0){
          if(lastParticle!=null){
            Particle newParticle = new Particle(particles.size(),j,i);
            particles.add(newParticle);
            lastParticle.next = newParticle;
            lastParticle = newParticle;
          } else {
            Particle newParticle = new Particle(particles.size(),j,i);
            particles.add(newParticle);
            lastParticle = newParticle;
          }
          id++;
        } else {
          if(lastParticle!=null) lastParticle.next = null;
          lastParticle = null;
        }
      }
    }
  }
  
  while(id<particles.size()){
    particles.remove(particles.size()-1);
  }

}

public void staticWidth(float theValue) {
  staticWidth = theValue;
}

public void logoStrength(float theValue) {
  logoStrength = theValue;
}

public void repulseStrength(float theValue) {
  repulseStrength = theValue;
}

public void repulseRange(float theValue) {
  repulseRange = theValue;
}

public void noiseStrength(float theValue) {
  noiseStrength = theValue;
}

public void noiseChange(float theValue) {
  noiseChange = theValue;
}

public void noiseFactor(float theValue) {
  noiseFactor = theValue;
}

public void noiseDirection(float theValue) {
  noiseDirection = theValue;
}

public void circleStrength(float theValue) {
  circleStrength = theValue;
}

public void circleRadius(float theValue) {
  circleRadius = theValue;
}


public void waveStrength(float theValue) {
  waveStrength = theValue;
}

public void waveMoveRange(float theValue) {
  waveMoveRange = theValue;
}

public void waveMoveFactor(float theValue) {
  waveMoveFactor = theValue;
}

public void waveWidth(float theValue) {
  waveWidth = theValue;
}

public void waveHeight(float theValue) {
  waveHeight = theValue;
}

public void waveFactorX(float theValue) {
  waveFactorX = theValue;
}

public void waveFactorY(float theValue) {
   waveFactorY = theValue;
}

public void lissajousStrength(float theValue){
  lissajousStrength = theValue;
}

public void lissajousXFreq(int theValue){
  lissajousXFreq = theValue;
}

public void lissajousYFreq(int theValue){
  lissajousYFreq = theValue;
}

public void lissajousPhase(int theValue){
  lissajousPhase = theValue;
}

public void pause() {
  pause = !pause;
  if(!pause) cp5.get(Textlabel.class,"opStatus").setText("Running");
  else cp5.get(Textlabel.class,"opStatus").setText("Pausing");
}

public void save() {
  if(showPoint){
      for(int i=0;i<particles.size();i++){
        pdf.ellipse(particles.get(i).pos.x, particles.get(i).pos.y,particles.get(i).size,particles.get(i).size);
      }
    }
    pdf.dispose();
    pdf.endDraw();    
    pdf=generatePDF();
    pdf.beginDraw();
    pdf.background(255);
    clearBackground();
    
    cp5.get(Textlabel.class,"opStatus").setText("Save Success!");
}

public void quit(){
  if(showPoint){
    for(int i=0;i<particles.size();i++){
      pdf.ellipse(particles.get(i).pos.x, particles.get(i).pos.y,particles.get(i).size,particles.get(i).size);
    }
  }
  pdf.dispose();
  pdf.endDraw();
  exit();
}

void controlEvent(ControlEvent theEvent) {
  CheckBox lifeCheckBox = cp5.get(CheckBox.class,"lifeCheckBox");
  ColorPicker pointColorPicker = cp5.get(ColorPicker.class,"pointColor");
  
  if(theEvent.isFrom(lifeCheckBox)) {
    unlimitedLife = lifeCheckBox.getArrayValue()[0]==1;
    sizeChangeOverLife = lifeCheckBox.getArrayValue()[1]==1;
  }
  else if(theEvent.isFrom(pointColorPicker)){
    pointColor = color(theEvent.getArrayValue(0),theEvent.getArrayValue(1),theEvent.getArrayValue(2),theEvent.getArrayValue(3));
  }
}
