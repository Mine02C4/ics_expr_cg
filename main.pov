#include "colors.inc" 
#include "shapes.inc"
#include "woods.inc"
#include "metals.inc"
#include "stones.inc"
#include "textures.inc"

#declare View = 1; // if this is 0, an image for test would be rendered.


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

#macro BaseMaterial()
  pigment {Gray60}
  finish{
    ambient 0.2
    diffuse 0.2
    phong 0.3
    reflection 0.03
  }
#end

#if (View)
camera{
  location <0, 15, -10>
  look_at<0, 5, 56>
  angle 30
}

light_source{<-5,30,0> color 2*White}

object{
  Plane_XZ
    texture{
      pigment{ NavyBlue }
      finish { Metal }
      normal { waves 0.5 frequency 20 scale 10 }
    }
    translate<0,-10,0>
}

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

#macro Illuminator()
#end


#macro SidePanel()
union{
  object{
    bicubic_patch {
       type 1
       flatness 0
       u_steps 4
       v_steps 4
       <0, 0,0>,    <5.0,-1,10>,   <10.5,  -4.6,   30>, <10.5,  -4.6,   51.5>,
       <0,-1,3>,    <5.0,-2,10>,   <10.28, -6.466, 30>, <10.28, -6.466, 51.5>,
       <0,-5,5>,    <1,  -5,10>,   <10.06, -8.333, 30>, <10.06, -8.333, 51.5>,
       <0,-10.2,6>, <1, -10.2,10>, <9.84,  -10.2,  30>, <9.84,  -10.2,  51.5>
       BaseMaterial()
    }
  }
  object{
    bicubic_patch {
       type 1
       flatness 0
       u_steps 4
       v_steps 4
       <10.5,   -4.6,   51.5>, <10.5, -4.6,   100>, <10,-4.6, 130>, <7.8,-4.6,165>,
       <10.28,  -6.466, 51.5>, <10.28,-6.466, 100>, <10,-6.0, 130>, <7.6,-6,165>,
       <10.06,  -8.333, 51.5>, <10.06,-8.333, 100>, <10,-8.8, 130>, <7.2,-8.8,165>,
       <9.84,   -10.2,  51.5>, <9.84, -10.2,  100>, <9, -10.2,130>, <7,-10.2,165>
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
        <0,0,0>, <5.0,-1,10>, <10, -4.6, 30>,  <10.5, -4.6, 51.5>,
        <0,0,0>, <4,-1,10>,   <9,  -4.6, 30>,  <9,    -4.6, 51.5>,
        <0,0,0>, <1,-1,10>,   <1,  -4.6, 30>,  <1,    -4.6, 51.5>,
        <0,0,0>, <0,-1,10>,   <0,  -4.6, 30>,  <0,    -4.6, 51.5>
        BaseMaterial()
      }
    }
    object {
      bicubic_patch {
         type 1
         flatness 0
         u_steps 4
         v_steps 4
         <10.5, -4.6, 51.5>, <10.5, -4.6,   100>, <10,-4.6, 130>, <7.8, -4.6,165>,
         <9,    -4.6, 51.5>, <9,    -4.6,   100>, <9, -4.6, 130>, <6,   -4.6,165>,
         <1,    -4.6, 51.5>, <1,    -4.6,   100>, <1, -4.6, 130>, <1,   -4.6,165>,
         <0,    -4.6, 51.5>, <0,    -4.6,   100>, <0, -4.6, 130>, <0,   -4.6,165>
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

#macro CIWS()
  union {
    cylinder {
      0,
      y*0.2,1.3
      BaseMaterial()
    }
    difference {
      prism {
        linear_sweep
        linear_spline
        0, 1.9,
        4,
        <-0.7, 0>, <-0.5, 2>, <0.5, 2>, <0.7, 0>
        rotate <-90, 90, 0>
        translate <0.95, 0, 0>
      }
      box {<-0.6, 0.5, -2>, <0.6, 3, 2>}
      BaseMaterial()
    }
    #macro CIWSBOX()
      box {<-0.6, 0, -0.6>,<0.6, 0.59, 0.6>}
    #end
    #macro CIWSTRUSS()
      prism {
        conic_sweep
        linear_spline
        0.5, 1,
        4,
        <-0.6, -0.28>, <-0.6, 0.28>, <0.6, 0.28>, <0.6, -0.28>
        translate <0, -1, 0>
        scale <1, 1.2, 1>
      }
    #end
    #macro CIWSTRUSSHOLE()
      union {
        prism {
          linear_sweep linear_spline -5, 5, 3,
          <-0.5, 0.05>,<0, 0.35>, <0.5, 0.05>
        }
        prism {
          linear_sweep linear_spline -5, 5, 3,
          <-0.2, 0.55>,<0, 0.42>, <0.2, 0.55>
        }
        prism {
          linear_sweep linear_spline -5, 5, 3,
          <-0.26, 0.51>, <-0.06, 0.38>, <-0.48, 0.11>
        }
        prism {
          linear_sweep linear_spline -5, 5, 3,
          <0.26, 0.51>, <0.06, 0.38>, <0.48, 0.11>
        }
        rotate <90, 0, 0>
      }
    #end
    union {
      difference {
        blob {
          threshold 0.1
          cylinder {
            0,
            y*1.5, 0.5,
            10
          }
          translate <0, 0.5, 0>
        }
        CIWSBOX()
        pigment {White}
        translate <0, -0.3, 0>
      }
      difference {
        CIWSBOX()
        box {
          <-0.5, 0.1, -1>,<0.5, 0.49, 1>
        }
        BaseMaterial()
        translate <0, -0.3, 0>
      }
      difference {
        CIWSTRUSS()
        object {
          CIWSTRUSS()
          scale 0.9
          translate <0, 0.1, 0>
        }
        CIWSTRUSSHOLE()
        object {
          CIWSTRUSSHOLE()
          scale <0.5, 1, 1>
          rotate <0, 90, 0>
        }
        BaseMaterial()
        rotate <90, 0, 0>
        translate <0, 0, -0.6>
      }
      cylinder {
        0,
        y*2.5, 0.1
        pigment {Black}
        rotate <-90, 0, 0>
      }
      cylinder {
        0,
        y*1, 0.4
        BaseMaterial()
        rotate <-90, 0, 0>
        translate <0, -0.7, 0.5>
      }
      translate <0, 1.7, 0>
    }
  }
#end

#macro RADAR1()
  union {
    union {
      sphere {
        <0, 1.6, 0>, 0.8
      }
      torus {
        0.78, 0.05
        translate <0, 1.6, 0>
      }
      cylinder {
        y*0.7, y * 1.6, 0.4
      }
      pigment {Wheat}
    }
    cylinder {
      0, y * 1.6, 0.3
      BaseMaterial()
    }
  }
#end

#macro RADAR2()
  union {
    difference {
      union {
        blob {
          threshold 0.1
          cylinder {
            0,
            y*1.5, 0.5,
            10
          }
          translate <0, 0.5, 0>
        }
        torus {
          0.46, 0.05
          translate <0, 1.5, 0>
        }
      }
      box {<-1, 0, -1>, <1, 1.3, 1>}
      pigment {White}
    }
    cone {
      0, 0.5,
      y*1.5, 0.1
      BaseMaterial()
    }
  }
#end

#declare bridgeHeight = 15.7;
#declare ratioBridgeBody = 0.8;
#declare bridgeSweepOffset = 16.8;

#macro BridgeBase(height)
  prism {
    conic_sweep
    linear_spline
    (1 - (1 - ratioBridgeBody) * height / bridgeHeight), 1,
    8,
    <6.3, (0 - bridgeSweepOffset)>,   <10.5, (6.3 - bridgeSweepOffset)>,  <10.5, (29.8 - bridgeSweepOffset)>, <6.3, (34 - bridgeSweepOffset)>,
    <-6.3, (34 - bridgeSweepOffset)>, <-10.5, (29.8 - bridgeSweepOffset)>,<-10.5, (6.3 - bridgeSweepOffset)>, <-6.3, (0 - bridgeSweepOffset)>
    BaseMaterial()
    translate<0, -1, bridgeSweepOffset>
    scale<1, -1 / (1 - ratioBridgeBody) * bridgeHeight, 1>
  }
#end
#macro BridgeBody(height, sfactor)
  prism {
    conic_sweep
    linear_spline
    ratioBridgeBody, 1,
    8,
    <4.3, (4.2 - bridgeSweepOffset)>,   <10.5, (9.4 - bridgeSweepOffset)>,    <10.5, (21.07 - bridgeSweepOffset)>, <6.3, (25.3 - bridgeSweepOffset)>,
    <-6.3, (25.3 - bridgeSweepOffset)>, <-10.5, (21.07 - bridgeSweepOffset)>, <-10.5, (9.4 - bridgeSweepOffset)>,  <-4.3, (4.2 - bridgeSweepOffset)>
    BaseMaterial()
    translate<0, -1, 0>
    scale sfactor
    translate<0, 0, bridgeSweepOffset>
    scale<1, -1 / (1 - ratioBridgeBody) * height, 1>
  }
#end

#macro Bridge()
  union {
    BridgeBody(bridgeHeight, 1)
    difference {
      object {
        BridgeBody(bridgeHeight, 0.83)
        scale <1, -1, 1>
        translate <0, bridgeHeight, 0>
      }
      #macro Window(X)
        box {
          <X, 14.5, 0>, <X + 1, 15.3, 6.5>
          pigment {Black}
        }
      #end
      #local N=0;
      #while (N<5)
        Window(-3 + N * 1.3)
        #local N = N + 1;
      #end
    }
    BridgeBase(3.2)
    intersection {
      BridgeBase(5.7)
      box {<-5.2, 0, 0>, <5.2, 5.7 ,10>}
      BaseMaterial()
    }
    difference {
      intersection {
        BridgeBase(9)
        box {<-3.1, 0, 0>, <3.2, 8 ,10>}
      }
      box {<-1.4, 7.5, 0>, <1.4, 9.7, 10>}
      BaseMaterial()
    }
    object {
      CIWS()
      translate <0, 7.5, 3.4>
    }
    box {
      <-1.75, 11.25, 4.2>, <1.75, 11.368, 8>
      BaseMaterial()
    }
    object {
      RADAR1()
      translate <-0.5, 11.368, 4.7>
    }
    object {
      RADAR2()
      translate <0.5, 11.368, 5.4>
    }
    translate<0, -4.6, 47.3>
  }
#end

object{
  Bridge()
}


#else
// Testing section
camera{
  location <0, 3, -5>
  look_at<0, 2, 0>
  angle 60
}

light_source{<-5,30,0> color 2*White}

object{
  Plane_XZ
    texture{
      pigment{ NavyBlue }
      finish { Metal }
      normal { waves 0.5 frequency 20 scale 10 }
    }
    translate<0,0,0>
}


object {RADAR2()}

#end
