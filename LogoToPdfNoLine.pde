import processing.pdf.*;
import java.util.Date;
import java.text.SimpleDateFormat;

PGraphics bg,pdf;
PImage img;
ArrayList<Particle> particles = new ArrayList<Particle>();
JSONArray values;

void initPos(){
  Particle lastParticle = null;
  //need black & white process
  for(int i=0;i<img.height;i+=pointDensity){
    for(int j=0;j<img.width;j+=pointDensity){
      float r = brightness(img.pixels[i*img.width+j]);
      if(r==0){
        if(i<minY) minY = i;
        if(i>maxY) maxY = i;
        if(j<minX) minX = j;
        if(j>maxX) maxX = j;
        
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
      } else {
        if(lastParticle!=null) lastParticle.next = null;
        lastParticle = null;
      }
    }
  }
}

void clearPDF(){
  pdf.dispose();
  pdf.endDraw();
  pdf.beginDraw();
}

PGraphics generatePDF(){
  Date dNow = new Date( );
  SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd-hh-mm-ss");
  File file=new File("output/output"+ft.format(dNow)+".pdf");
  File path = new File("output");
  if(!path.exists()) path.mkdir(); 
  if(!file.exists()) 
  {
    try{
       if (!path.exists()) {
        path.mkdir();
        file.createNewFile();
      }
    } catch(Exception e){
      println(e);
      exit();
    }
  }
  return createGraphics(width, height, PDF, "output/output"+ft.format(dNow)+".pdf");
}

void clearBackground(){
  bg.beginDraw();
  bg.background(255);
  bg.endDraw();
}

void setup() {
  cp5 = new ControlP5(this);
  initUI();
    
  img = loadImage("logo.png");
  fullScreen();  
  r=height/2;
  
  float _factor = (float)height/img.height;
  img.resize((int)(_factor*img.width), (int)(_factor*img.height));
  img.loadPixels();
  
  
  initPos();
  
  
  bg = createGraphics(width, height);pdf = generatePDF();
  bg.beginDraw();pdf.beginDraw();
  bg.background(255);pdf.background(255);
  bg.endDraw();
  
  strokeWeight(5);
  //background(255);
}

void draw() {
  if(!pause){
    fill(255, 20);
    noStroke();
    //rect(0, 0, width, height);//fading tail
    //background(255);//line tail
    noiseDetail(2,0.3);
  
    
    image(bg,0,0);
    bg.beginDraw();

    //bg.fill(255, 255/tailLength);
    //bg.rect(0,0,width,height);
    bg.fill(0);pdf.fill(0);
    for(int i=0;i<particles.size();i++){
      particles.get(i).move();
      particles.get(i).display();
    }
    bg.endDraw();
  }
}

void keyPressed() {
  if(key == 'q'){
    quit();
  }
  if(key == 's'){
    save();
  } if(key == ' '){
    pause();
  }
}
