#include "colors.inc" 
#include "shapes.inc"
#include "woods.inc"
#include "metals.inc"
#include "stones.inc"
#include "textures.inc"

#declare View = 1; // if this is 0, an image for test would be rendered.

#if (View)
camera{
  //location <-10*sin(clock*3),clock*10,-20*cos(clock*3)>
  location <30, 10,-60>
  look_at<0, -6,165>
  //location <-3,-1,-6>  
  //look_at<1.414,3,-1.414>
  angle 50
}

light_source{<-5,20,-20> color 2*White}

sky_sphere{
  pigment{
    wrinkles
    color_map{
      [ 0.3 color rgb<0.3,0.4,1.2>]
      [ 0.9 White ]
    }
    scale <1, 0.2, 0.2>
  }
}

object{ 
  Plane_XZ
    texture{
      pigment{ NavyBlue }
      finish { Metal }
      normal { waves 0.5 frequency 20 scale 10 }
    }
    translate<0,-10,0>
}

#macro Illuminator()
#end

#macro BaseMaterial()
//pigment{checker White*1.2, color rgb<0.2,1,1> scale 0.5}
  pigment {Gray60}
  finish{
    ambient 0.2
    diffuse 0.2
    phong 0.3
    reflection 0.03
  }
#end

#macro SidePanel()
union{
  object{
    bicubic_patch {
       type 1
       flatness 0
       u_steps 4
       v_steps 4
       <0, 0,0>,    <5.0,-1,10>,   <10.5,  -4.6,   30>, <10.5,  -4.6,   76.2>,
       <0,-1,3>,    <5.0,-2,10>,   <10.28, -6.466, 30>, <10.28, -6.466, 76.2>,
       <0,-5,5>,    <1,  -5,10>,   <10.06, -8.333, 30>, <10.06, -8.333, 76.2>,
       <0,-10.2,6>, <1, -10.2,10>, <9.84,  -10.2,  30>, <9.84,  -10.2,  76.2>
       BaseMaterial()
    }
  }
  object{
    bicubic_patch {
       type 1
       flatness 0
       u_steps 4
       v_steps 4
       <10.5,   -4.6,   76.2>, <10.5, -4.6,   100>, <10,-4.6, 130>, <7.8,-4.6,165>,
       <10.28,  -6.466, 76.2>, <10.28,-6.466, 100>, <10,-6.0, 130>, <7.6,-6,165>,
       <10.06,  -8.333, 76.2>, <10.06,-8.333, 100>, <10,-8.8, 130>, <7.2,-8.8,165>,
       <9.84,   -10.2,  76.2>, <9.84, -10.2,  100>, <9, -10.2,130>, <7,-10.2,165>
       BaseMaterial()
     }
  }
}
#end
object{
  SidePanel()
}
object{
  SidePanel()
  scale<-1,1,1>
}

#macro Deck()
  union {
    object {
      bicubic_patch{
        type 1
        flatness 0
        u_steps 4
        v_steps 4
        <0,0,0>, <5.0,-1,10>, <10, -4.6, 30>,  <10.5, -4.6, 76.2>,
        <0,0,0>, <4,-1,10>,   <9,  -4.6, 30>,  <9,    -4.6, 76.2>,
        <0,0,0>, <1,-1,10>,   <1,  -4.6, 30>,  <1,    -4.6, 76.2>,
        <0,0,0>, <0,-1,10>,   <0,  -4.6, 30>,  <0,    -4.6, 76.2>
        BaseMaterial()
      }
    }
    object {
      bicubic_patch {
         type 1
         flatness 0
         u_steps 4
         v_steps 4
         <10.5, -4.6, 76.2>, <10.5, -4.6,   100>, <10,-4.6, 130>, <7.8, -4.6,165>,
         <9,    -4.6, 76.2>, <9,    -4.6,   100>, <9, -4.6, 130>, <6,   -4.6,165>,
         <1,    -4.6, 76.2>, <1,    -4.6,   100>, <1, -4.6, 130>, <1,   -4.6,165>,
         <0,    -4.6, 76.2>, <0,    -4.6,   100>, <0, -4.6, 130>, <0,   -4.6,165>
         BaseMaterial()
       }
    }
    translate<0,-0.1,0>
  }
#end

object{
  Deck()
}
object{
  Deck()
  scale<-1,1,1>
}

#macro Bridge()
  union {

  }
#end

#else
// Testing section
#end
