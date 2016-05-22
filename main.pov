#include "colors.inc"
#include "shapes.inc"
#include "woods.inc"
#include "metals.inc"
#include "stones.inc"
#include "textures.inc"
#include "skies.inc"

#declare View = 1; // if this is 0, an image for test would be rendered.
#declare HD = 1; // if this is 1, an high quality image would be rendered.
#declare Camera = 1; // if this is 0, the camera position would be set test position.

global_settings {
  number_of_waves 20
}


#macro BaseMaterial()
  pigment {
    color rgb<0.61, 0.6, 0.65>
  }
  finish{
    ambient 0.2
    diffuse 0.5
    phong 0.3
    reflection 0.01
  }
#end

#if (View)
  #if (Camera)
    camera {
      location <10, 10, -60>
      look_at <-10, 0, 60>
      angle 60
    }
  #else
    camera {
      location <10, 1, 0>
      look_at <0, 0, 30>
      angle 60
    }
  #end

sky_sphere {
  S_Cloud1
}

light_source {
  <10, 60,-10> color White
  shadowless
}
light_source {
  <-10, 10, -10> color Copper*2
  parallel
  point_at 0
}

union {
  #declare fn_A=function{sqrt(pow(x,2)+pow(y,2)+pow(z,2))-1.5}
  #declare fn_C=function{y}
  #declare Blob_threshold = 0.01;
  isosurface {
    function {
      1 + Blob_threshold
      - pow( Blob_threshold, fn_A(x,y,z) )
      - pow( Blob_threshold, fn_C(x,y,z) )
    }
    contained_by { box { -3, 3 } }
    max_gradient 6
    scale 1.4
  }
  Plane_XZ
  texture {
    pigment { NavyBlue * 0.05 }
    finish { Metal }
    normal { waves 0.7 frequency 20 scale 5 }
  }
  translate <0, -10, 12.5>
}

/*
superellipsoid {
  <0.2,0.2>
  pigment {
    bozo color_map{[0.0 color NavyBlue][0.7 White transmit 0.7]}
    scale 0.03
  }
  translate <1, 0, 1>
  scale <50, 2, 50>
  //rotate <1, 0, 0>
  rotate <0, -45, 0>
  rotate <2.9, 0, 0>
  translate <0, -10, 9.5>
}*/

#macro Bobble(S)
  sphere {
    0, 1
    translate <0, 0, 1>
    scale <0.2, 0.2, 0.5>
    scale S
    rotate <0, 45, 0>
  }
#end

#macro HeadWaveR(TurnFactor)
  union {
    #local Far = 80;
    #local R = seed(100);
    #local X = 0;
    #while (X < Far)
      #local S = (Far - X) * 0.05;
      object {
        Bobble(S)
        translate <X, rand(R) * 0.3, X>
        rotate y*X*TurnFactor
      }
      #local I = 0;
      #local Mz = exp(-0.05*X) * 40;
      #while (I < Mz)
        object {
          Bobble(S * 0.5 * (Mz - I) / Mz)
          translate <X, rand(R) * 0.2, X + I>
          rotate y*X*TurnFactor
        }
      #local I = I + 0.3 * exp(0.1*I);
      #end
      #local X = X + 0.1;
    #end
    #if (HD)
      pigment { Gray70 filter 0.2 transmit 0.6}
    #else
      pigment { Gray70 transmit 0}
    #end
    finish { Dull }
  }
#end

#macro HeadWave()
  #local TurnFactor = 0.1;
  union {
    union {
      object {
        HeadWaveR(-1*TurnFactor)
      }
      object {
        HeadWaveR(TurnFactor)
        scale <-1, 1, 1>
      }
      translate <0, 0, 11>
    }
    union {
      object {
        HeadWaveR(-1*TurnFactor)
      }
      object {
        HeadWaveR(TurnFactor)
        scale <-1, 1, 1>
      }
      scale 0.8
      translate <0, 0, 150>
    }
    translate <0, -10, 0>
  }
#end
object {
  HeadWave()
}

#macro SidePanel()
union{
  object{
    bicubic_patch {
       type 1
       flatness 0
       u_steps 4
       v_steps 4
       <0, 0,0>,    <5.0,-1,10>,   <10.5,  -4.6,   30>, <10.5,  -4.6,   51.5>,
       <0,-5,5>,    <5.0,-2,10>,   <10.28, -6.466, 30>, <10.28, -6.466, 51.5>,
       <0,-6,8>,    <1,  -5,10>,   <10.06, -8.333, 30>, <10.06, -8.333, 51.5>,
       <0,-10.2,10>, <1, -10.2,10>, <9.84,  -10.2,  30>, <9.84,  -10.2,  51.5>
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

#macro Deck()
  union {
    bicubic_patch{
      type 1
      flatness 0
      u_steps 4
      v_steps 4
      <0,0,0>, <5.0,-1,10>, <10.5, -4.6, 30>,  <10.5, -4.6, 51.5>,
      <0,0,0>, <4,-1,10>,   <9,  -4.6, 30>,  <9,    -4.6, 51.5>,
      <0,0,0>, <1,-1,10>,   <1,  -4.6, 30>,  <1,    -4.6, 51.5>,
      <0,0,0>, <0,-1,10>,   <0,  -4.6, 30>,  <0,    -4.6, 51.5>
      BaseMaterial()
    }
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
    #macro FenceWire(H, R)
      #local O = H + R * 0.5;
      #local P = H + R;
      bicubic_patch{
        type 1
        flatness 0
        u_steps 4
        v_steps 4
        <0,0 + H,0>, <5.0,-1 + H,10>, <10.5, -4.6 + H, 30>,  <10.5, -4.6 + H, 51.5>,
        <0,0 + O,0>, <5.0,-1 + O,10>, <10.5, -4.6 + O, 30>,  <10.5, -4.6 + O, 51.5>,
        <0,0 + O,0>, <5.0,-1 + O,10>, <10.5, -4.6 + O, 30>,  <10.5, -4.6 + O, 51.5>,
        <0,0 + P,0>, <5.0,-1 + P,10>, <10.5, -4.6 + P, 30>,  <10.5, -4.6 + P, 51.5>
        BaseMaterial()
      }
    #end
    FenceWire(0.3, 0.03)
    FenceWire(0.6, 0.03)
    FenceWire(0.9, 0.03)
    FenceWire(1.2, 0.03)
    difference {
      FenceWire(0, 1.3)
      union {
        #local Z = 0;
        #local PaulInterval = 1.5;
        #while (Z < 100)
          box {<0, -10, Z>, <10, 2, Z + PaulInterval - 0.05>}
          #local Z = Z + PaulInterval;
        #end
      }
      BaseMaterial()
    }
    translate<0,-0.01,0>
  }
#end


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

#macro RADAR3()
  difference {
    blob {
      threshold 0.1
      cylinder {
        0,
        y*1.7, 0.9,
        10
      }
    }
    box {<-1, -10, -1>, <1, 0, 1>}
    pigment {White}
  }
#end

#macro RADAR4()
  union {
    union {
      sphere {
        <0, 2.1, 0>, 1
      }
      cone {
        <0, 1, 0>, 0.8,
        <0, 2.05, 0>, 0.999
      }
      pigment {White}
    }
    union {
      cone {
        <0, 1, 0>, 0.8
        <0, 0.8, 0>, 0.3
      }
      cone {
        <0, 0.8, 0>, 0.3,
        <0, 0, 0>, 0.5
      }
      BaseMaterial()
    }
  }
#end

#macro Illuminator()
  union {
    union {
      difference {
        intersection {
          sphere {
            <0, 2, 0>, 2
          }
          cylinder {
            0, y * 2, 1
          }
        }
        quadric{
          <0.31,0,0.31>, <0,0,0>, <0,-1,0>, 0
          translate y*0.1
        }
        translate <0, 0.3, 0>
        BaseMaterial()
      }
      cylinder {
        y * -0.2, y * 0.3, 0.3
      }
      rotate <-70, 0, 0>
      translate <0, 1.5, 0>
    }
    cylinder {
      0, y * 1.5, 0.4
    }
    BaseMaterial()
  }
#end

#macro SPY1()
  union {
    prism {
      linear_sweep
      linear_spline
      0, 0.2, 8,
      <2.12,  1.4>,  <0.88, 2.12>, <-0.88, 2.12>, <-2.12, 1.4>,
      <-2.12, -1.4>, <-0.88, -2.12>, <0.88, -2.12>, <2.12, -1.4>
      pigment {Wheat}
    }
    #macro SPY1BOLT()
      cylinder {
        0, y*0.3, 0.04
        BaseMaterial()
      }
    #end
    object { SPY1BOLT() translate <1, 0, 1.8> }
    object { SPY1BOLT() translate <-1, 0, 1.8> }
    object { SPY1BOLT() translate <1, 0, -1.8> }
    object { SPY1BOLT() translate <-1, 0, -1.8> }
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

#macro MastBaseSpace()
  intersection {
    prism {
      linear_sweep
      linear_spline
      0, -30,
      3,
      <-2.9, 15>, <0, 28.8>, <2.9, 15>
      rotate <-90, 0, 0>
    }
    prism {
      linear_sweep
      linear_spline
      10, -10,
      3,
      <9.46, 0>, <19, 49>, <29.8, 0>
      rotate <-90, -90, 0>
    }
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
      box {<-1.4, 7.5, 0>, <1.4, 9.7, 11>}
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
    #macro LSPY1()
      object {
        SPY1()
        rotate <-81, -40, 0>
        translate <6.5, 10, 8.1>
      }
    #end
    object {
      LSPY1()
    }
    object {
      LSPY1()
      scale <-1, 1, 1>
    }
    intersection {
      MastBaseSpace()
      box {<-5, 0, 0>, <5, 18.8, 30>}
      BaseMaterial()
    }
    object {
      Illuminator()
      translate <0, 18.8, 17>
    }
    cylinder {
      0, y*0.3, 2
      translate <3, 18.5, 19>
      BaseMaterial()
    }
    object {
      RADAR4()
      translate <3.5, 18.8, 19>
    }
    cylinder {
      0, y*0.3, 2
      translate <-3, 18.5, 19>
      BaseMaterial()
    }
    object {
      RADAR4()
      translate <-3.5, 18.8, 19>
    }
    intersection {
      MastBaseSpace()
      prism {
        linear_sweep
        linear_spline
        10, -10,
        3,
        <17, 0>, <22.6, 28.8>, <29.8, 0>
        rotate <-90, -90, 0>
      }
      BaseMaterial()
    }
    intersection {
      prism {
        linear_sweep
        linear_spline
        10, -10,
        4,
        <17.1, 0>, <23.4, 33.2>, <24.7, 33.2>, <19.1, 0>
        rotate <-90, -90, 0>
      }
      box {<-1.17, 15, 0>, <1.17, 33.4, 30>}
      BaseMaterial()
    }
    cylinder {
      0, y*0.3, 2
      translate <0, 23.4, 23>
      BaseMaterial()
    }
    cylinder {
      0, y*0.3, 2
      translate <0, 26.6, 23>
      BaseMaterial()
    }
    #macro RBAR()
      union {
        box {
          <0, 26.6, 23.2> , <6.5, 26.9, 23.5>
          BaseMaterial()
        }
        box {
          <0, 0, 0> , <5.5, 0.2, 0.2>
          rotate <0, 0, 15>
          translate <0, 25.15, 23.4>
          BaseMaterial()
        }
      }
    #end
    object {
      RBAR()
    }
    object {
      RBAR()
      scale x*-1
    }
    cylinder {
      0, y*0.3, 2
      translate <0, 28.6, 21>
      BaseMaterial()
    }
    object {
      RADAR3()
      translate <0, 28.9, 21>
    }
    cylinder {
      0, y*0.5, 2
      translate <0, 33.2, 24>
      BaseMaterial()
    }
    cylinder {
      0, y*8.5, 0.3
      rotate <10, 0, 0>
      translate <0, 33.2, 25>
      BaseMaterial()
    }
    translate<0, -4.6, 47.3>
  }
#end

#macro MainGun()
  union {
    union {
      difference {
        intersection {
          prism {
            linear_sweep
            linear_spline
            -2, 12,
            4,
            <-2, 0>, <-1.3, 3.1>, <1.3, 3.1>, <2, 0>
            rotate <-90, -90, 0>
          }
          prism {
            linear_sweep
            linear_spline
            -3, 3,
            4,
            <-1.5, 0>, <-1, 3>, <1, 3>, <1.5, 0>
            rotate <-90, 0, 0>
          }
          prism {
            conic_sweep
            linear_spline
            0.3, 1,
            4,
            <2.5, 0>, <0, 2.7>, <-2.7, 0>, <0, -2.5>
            translate <0, -1, 0>
            scale <1, -22, 1>
          }
        }
        box {<-0.38, 1, -5>, <0.38, 4, 0.2>}
      }
      union {
        cylinder {
          y*0.2, y*0.38, 1
        }
        cylinder {
          y*-0.2, y*-0.38, 1
        }
        rotate <0, 0, 90>
        translate <0, 1.9, -0.5>
      }
      difference {
        cylinder {
          0, y*8, 0.17
        }
        cylinder {
          -0.1, y*8.1, 0.1
        }
        rotate <-80, 0, 0>
        translate <0, 1.9, 0>
      }
      translate <0, 0.2, 0>
    }
    cylinder {
      0, y*0.2, 1.3
    }
    box {<-1.4, -3, -1.4>, <1.4, 0, 1.4>}
    translate <0, -3 , 28>
    BaseMaterial()
  }
#end

#macro VLS()
  #macro VLSCell()
    union {
      superellipsoid {
        <0.2,0.2>
        scale <0.4, 0.025, 0.4>
        translate <0, 0.025, 0>
      }
      cylinder {
        <-0.3, 0.025, -0.45>, <0.3, 0.025, -0.45>, 0.025
      }
      cylinder {
        <0.23, 0, -0.42>, <0.29, 0, -0.42>, 0.07
      }
      cylinder {
        <-0.23, 0, -0.42>, <-0.29, 0, -0.42>, 0.07
      }
    }
  #end

  #macro VLSModule()
    union {
      #local N = 0;
      #while (N < 4)
        object {
          VLSCell()
          translate <-1.35 + 0.9 * N, 0, -0.5>
        }
        object {
          VLSCell()
          translate <-1.35 + 0.9 * N, 0, -0.5>
          scale <1, 1, -1>
        }
        #local N = N + 1;
      #end
    }
  #end
  union {
    box {<-4.1, -3,-4.1>, <4.1, -0.7, 4.1>}
    superellipsoid {
      <0.05,0.05>
      scale <4.1, 0.25, 4.1>
      translate <0, -0.25, 0>
    }
    superellipsoid {
      <0.05,0.05>
      scale <4.1, 0.25, 4.1>
      translate <0, -0.4, 0>
    }
    #local M = 0;
    #while (M < 4)
      object {
        VLSModule()
        translate <-2.05, 0, -3.075 + 2.05 * M>
      }
      object {
        VLSModule()
        translate <2.05, 0, -3.075 + 2.05 * M>
      }
      #local M = M + 1;
    #end
    translate <0, -3.9, 40>
    pigment {Gray60}
  }
#end

#macro Atago()
  union {
    object{
      SidePanel()
    }
    object{
      SidePanel()
      scale<-1,1,1>
    }
    object{
      Deck()
    }
    object{
      Deck()
      scale<-1,1,1>
    }
    object {
      MainGun()
    }
    object{
      Bridge()
    }
    object {
      VLS()
    }
    translate y*10
    rotate <0, 0, -3>
    translate y*-10
  }
#end

object {
  Atago()
}

#else
// Testing section
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

camera{
  location <0, 15, -20>
  look_at<0, 0, 0>
  angle 30
}

#end
