$fn=200;

/* [Parameters] */
do_telepod = true ;
do_bright_center = false ;
do_circles = true ;

module telepod_circle(h,r) {
    difference() {
        scale([1.12,1.12,0.09]) {
            sphere(r=r);
        }
        cylinder(h=10*h,r=6*r/7,center=true);
    }
}

module telepod_circle_old(h,r) {
    scale([1,1,0.5]) {
        difference() {
            minkowski() { // minkowski
                cylinder(h=h,r=r,center=true);
                sphere(r=h/1);
            }
            cylinder(h=4*h,r=5*r/6,center=true);
        }
    }
}

module telepod_circle_v(h,r) {
    difference() {
        scale([3,3,0.7]) {
            sphere(r=r);
        }
        cylinder(h=4*h,r=1.5*r,center=true);
        translate([0,-5*r,0]) {
            cube([7*r,10*r,7*r],center=true);
        }
    }
}

module telepod_circle_v_old(h,r) {
    scale([1,1,0.2]) {
        difference() {
            minkowski() { // minkowski
                cylinder(h=h,r=r,center=true);
                sphere(r=h/1);
            }
            cylinder(h=4*h,r=1.5*r,center=true);
            translate([0,-5*r,0]) {
                cube([7*r,10*r,7*r],center=true);
            }
        }
    }
}

telepod_circle_h = 1 ;
telepod_circle_r = 20 ;

module telepod_part_2_3(test) {

    p1_r1 = 5*telepod_circle_r/6 + 1;
    p1_r2 = 5*(telepod_circle_r+(5*0.1))/6 + 1;
    p1_h  = telepod_circle_h + 6*2.5*telepod_circle_h ;

    p2_r1 = 5*(telepod_circle_r+(5*0.1))/6 + 1 ;
    p2_r2 = 5*(telepod_circle_r-((5+11)*0.3))/6 + 1;
    p2_h = 3*telepod_circle_h + 10*2.5*telepod_circle_h ;

    union()  {
        if ( ! test ) {
            telepod_circle(telepod_circle_h, telepod_circle_r);
            for(telepod_step=[1:1:5]) {
                translate([0,0,telepod_step*2.5*telepod_circle_h]) {
                    telepod_circle(telepod_circle_h, telepod_circle_r+(telepod_step*0.1));
                }
            }
        }    
        translate([0,0,-(telepod_circle_h)]) {
            cylinder(h=p1_h+1, r1=p1_r1, r2=p1_r2);
        }
    
        if ( ! test ) {
            for(telepod_step=[1:1:11]) {
                translate([0,0,(5+telepod_step)*2.5*telepod_circle_h]) {
                    telepod_circle(telepod_circle_h, telepod_circle_r-((5+telepod_step)*0.3));
                }
            }
            translate([0,0,(5+11)*2.5*telepod_circle_h]) {
                telepod_circle(telepod_circle_h, telepod_circle_r-((5+11)*0.3));
                rt = telepod_circle_r-((5+18)*0.3) ;
                for(alpha=[0:10:360]) {
                    translate([rt*sin(alpha),rt*cos(alpha),0]) {
                        rotate([90,0,-alpha+90]) {
                            telepod_circle_v(2,1);
                        }
                    }
                }
            }
        }
        translate([0,0,p1_h]) {
            cylinder(h=p2_h, r1=p2_r1, r2=p2_r2);
        }

        translate([0,0,p1_h+p2_h]) {
            scale([1,1,0.3]) {
                sphere(r=p2_r2);
            }
        }
    
    }
}

module aileron(p0_r1,p0_r2,p0_h) {
    hull() {
        union() {
            translate([p0_r1+(p0_r2-p0_r1)/2,0,-p0_h/2]) {
                rotate([0,10,0]) {
                    cube([6,1,p0_h/2-1]);
                }
            }
            translate([p0_r1,0,-p0_h+2]) {
                cube([8,1,p0_h/2-1]);
            }
            translate([p0_r1+(p0_r2-p0_r1)/2+8-1.5,0.5,-p0_h/2-0.1]) {
                rotate([90,10,0]) {
                    scale([0.4,1,1]) {
                        cylinder(h=1,r=8.5,center=true);
                    }
                }
            }
        }
    }
}

module telepod_part_1(test) {
    p0_r1 = 5*(telepod_circle_r-((5+11)*0.3))/6 + 1;
    p0_r2 = 5*telepod_circle_r/6 + 1;
    p0_h  = telepod_circle_h + 8*2.5*telepod_circle_h ;
   
    translate([0,0,-p0_h]) {
        cylinder(h=p0_h, r1=p0_r1, r2=p0_r2);
    }
    if ( ! test ) {
        translate([-3,0,0]) {
            ep=1;
            translate([0,-ep/2,0]) {
                aileron(p0_r1, p0_r2, p0_h);
            }
            translate([0,-ep/2 -ep - ep/2,0]) {
                aileron(p0_r1, p0_r2, p0_h);
            }
            translate([0,-ep/2 -ep - ep/2 -ep - ep/2,0]) {
                aileron(p0_r1, p0_r2, p0_h);
            }
            translate([0,-ep/2 -ep - ep/2 -ep - ep/2 -ep - ep/2,0]) {
                aileron(p0_r1, p0_r2, p0_h);
            }

            translate([0,-ep/2 +ep + ep/2,0]) {
                aileron(p0_r1, p0_r2, p0_h);
            }

            translate([0,-ep/2 +ep + ep/2 +ep + ep/2,0]) {
                aileron(p0_r1, p0_r2, p0_h);
            }
            translate([0,-ep/2 +ep + ep/2 +ep + ep/2 +ep + ep/2,0]) {
                aileron(p0_r1, p0_r2, p0_h);
            }
            translate([-4,-ep/2 +ep + ep/2 +ep + ep/2 +ep + ep/2 +ep + ep/2,0]) {
                aileron(p0_r1, p0_r2, p0_h);
            }
            scale([1,1,0.8]) {
                translate([-2,-ep/2 +ep + ep/2 +ep + ep/2 +ep + ep/2 +ep + ep/2 +ep + ep/2,0]) {
                    aileron(p0_r1, p0_r2, p0_h);
                }
            }
        }

        rotate([0,0,180]) {
            translate([-3,0,0]) {
                ep=1;
                translate([0,-ep/2,0]) {
                    aileron(p0_r1, p0_r2, p0_h);
                }
                translate([0,-ep/2 -ep - ep/2,0]) {
                    aileron(p0_r1, p0_r2, p0_h);
                }
                translate([0,-ep/2 -ep - ep/2 -ep - ep/2,0]) {
                    aileron(p0_r1, p0_r2, p0_h);
                }
                translate([0,-ep/2 -ep - ep/2 -ep - ep/2 -ep - ep/2,0]) {
                    aileron(p0_r1, p0_r2, p0_h);
                }

                translate([-4,-ep/2 -ep - ep/2 -ep - ep/2 -ep - ep/2 -ep - ep/2,0]) {
                    aileron(p0_r1, p0_r2, p0_h);
                }

                scale([1,1,0.8]) {
                    translate([-2,-ep/2 -ep - ep/2 -ep - ep/2 -ep - ep/2 -ep - ep/2 -ep - ep/2,0]) {
                        aileron(p0_r1, p0_r2, p0_h);
                    }
                }
                translate([0,-ep/2 +ep + ep/2,0]) {
                    aileron(p0_r1, p0_r2, p0_h);
                }

                translate([0,-ep/2 +ep + ep/2 +ep + ep/2,0]) {
                    aileron(p0_r1, p0_r2, p0_h);
                }
                translate([0,-ep/2 +ep + ep/2 +ep + ep/2 +ep + ep/2,0]) {
                    aileron(p0_r1, p0_r2, p0_h);
                }
            }
        }
    }
}
module telepod_body(test) {
    translate([0,0,telepod_circle_h]) {
        telepod_part_2_3(test);
    }
    telepod_part_1(test);
}

module door() {
    y1 = 5*telepod_circle_r/6 + 1;
    z1 = 0 ;
    
    y2 = 5*(telepod_circle_r+(5*0.1))/6 + 1;
    z2 = telepod_circle_h + 6*2.5*telepod_circle_h + 1;

    y3 = 5*(telepod_circle_r-((5+11)*0.3))/6 + 1+3;
    z3 = 27 ;

    y4 = 5*(telepod_circle_r-((5+11)*0.3))/6 + 3;
    z4 = telepod_circle_h + 8*2.5*telepod_circle_h - 9 ;

    width_1 = 8 ;
    width_2 = 18 ;

    union() {
        hull() {
            translate([0,y3,z3]) {
                cube([width_1,25,0.2],center=true);
            }

            translate([0,y2,z2/2]) {
                cube([width_2,25,0.2],center=true);
            }
        }
        hull() {
            translate([0,y2,z2/2]) {
                cube([width_2,25,0.2],center=true);
            }
            translate([0,y1,z1]) {
                cube([width_2,25,0.2],center=true);
            }
        }
        hull() {
            translate([0,y1,z1]) {
                cube([width_2,25,0.2],center=true);
            }
            translate([0,y4,-z4]) {
                cube([width_1,25,0.2],center=true);
            }
        }
        translate([0,y4,-z4]) {
            rotate([90,90,0]) {
                scale([0.5,1,1]) {
                    cylinder(h=25,d=width_1,center=true);
                }
            }
        }
    }
}

module hublot() {
    x1 = 5*(telepod_circle_r+(5*0.1))/6 + 1;
    z1 = telepod_circle_h + 6*2.5*telepod_circle_h + 1;

    x2 = 5*(telepod_circle_r-((5+11)*0.3))/6 + 1+3;
    z2 = 27 ;

    x3 = x1 + ((x2 - x1)/2) + 0;
    z3 = z1 + ((z2 - z1)/2) + 1.4;


    translate([-x3,0,z3]) {
        rotate([0,120,0]) {
            difference() {
                cylinder(h=8,r=4.7,center=true); // 3 3.2
                cylinder(h=9,r=3.5,center=true);   // 3 2
            }
        }
    }
}

module hublot_diff() {
    x1 = 5*(telepod_circle_r+(5*0.1))/6 + 1;
    z1 = telepod_circle_h + 6*2.5*telepod_circle_h + 1;

    x2 = 5*(telepod_circle_r-((5+11)*0.3))/6 + 1+3;
    z2 = 27 ;

    x3 = x1 + ((x2 - x1)/2) + 1;
    z3 = z1 + ((z2 - z1)/2) + 2;


    translate([-x3,0,z3]) {
        rotate([0,120,0]) {
            cylinder(h=14,r=4.5,center=true); // 3
        }
    }
}

module bright_center_diff() {
    z0  = telepod_circle_h + 8*2.5*telepod_circle_h ;
    translate([0,0,-z0 + 5 ]) {
        cylinder(h=6,r1=4,r2=4,center=true);
    }
}

module bright_center() {
    z0  = telepod_circle_h + 8*2.5*telepod_circle_h ;
    translate([0,0,-z0 + 5 ]) {
        hull() {
            cylinder(h=4,r1=8,r2=8,center=true);
            translate([0,0,1.3]) {
                scale([1,1,0.4]) {
                    sphere(r=8);
                }
            }
        }
    }
}

module only_bright_center() {
    z0  = telepod_circle_h + 8*2.5*telepod_circle_h ;
    hull() {
        cylinder(h=4,r1=8,r2=8,center=true);
        translate([0,0,1.3]) {
            scale([1,1,0.4]) {
                sphere(r=8);
            }
        }
    }
}

module round_cube(x,y,z,r) {
    dx = x/2-r/2;
    dy = y/2-r/2;
    hull() {
        translate([-dx,dy,0]) {
            cylinder(h=z,r=r/2,center=true);
        }
        translate([dx,-dy,0]) {
            cylinder(h=z,r=r/2,center=true);
        }
        translate([-dx,-dy,0]) {
            cylinder(h=z,r=r/2,center=true);
        }
        translate([dx,dy,0]) {
            cylinder(h=z,r=r/2,center=true);
        }
    }
}

module front() {
    cote_x = 16.5 ;
    cote_y = 8 ;
    cote_z = 1 ;
    cote_r = 1 ;

    front_x = 30.5 ;
    front_y = 4.5 ; 
    front_z = 1 ;
    front_r = 1 ;

    alpha = 100 ;

    translate([front_x/2-cote_z/2,-(cote_y/2)/3,0]) {
        rotate([0,alpha,0]) {
            translate([-cote_x/2,0,0]) {
                round_cube(cote_x,cote_y,cote_z,cote_r);
            }
        }
    }

    translate([-(front_x/2-cote_z/2),-(cote_y/2)/3,0]) {
        rotate([0,-alpha,0]) {
            translate([cote_x/2,0,0]) {
                round_cube(cote_x,cote_y,cote_z,cote_r);
            }
        }
    }
    translate([0,0,front_y/2]) {
        rotate([90,0,0]) {
            round_cube(front_x,front_y,front_z,front_r);
        }
    }
}

module telepod() {
    union() {
        scale([1,1,0.9]) {
            translate([0,0,telepod_circle_h + 8*2.5*telepod_circle_h]) {
                if ( do_bright_center ) {
                    union () {
                        difference() {
                            difference() {
                                difference() {
                                    telepod_body(!do_circles);
                                    scale([0.8,0.8,0.8]) {
                                        telepod_body(true);
                                    }    
                                }
                                door();
                            }
                            hublot_diff();
                        }
                        hublot();
                        bright_center();
                    }
                } else {
                    difference() {
                        union() {
                            difference() {
                                difference() {
                                    difference() {
                                        telepod_body(!do_circles);
                                        scale([0.8,0.8,0.8]) {
                                            telepod_body(true);
                                        }    
                                    }
                                    door();
                                }
                                hublot_diff();
                            }
                            hublot();
                        }
                        translate([0,0,-3]) {
                            bright_center_diff();
                        }
                    }
                }
            }
        }
        translate([0,5*(telepod_circle_r-((5+11)*0.3))/6 ,0]) {
            front();
        }
    }
}

if ( do_telepod ) {
    telepod() ;
} else {
    if ( do_bright_center ) {
        scale([1,1,0.9]) {
            difference() {
                only_bright_center();
                translate([0,0,-1]) {
                    scale([0.9,0.9,1]) {
                        only_bright_center();
                    }
                }
            }
        }
    }
}
/*
telepod_step = 5 ;
telepod_circle(telepod_circle_h, telepod_circle_r+(telepod_step*0.1));

telepod_step = 11 ;
telepod_circle(telepod_circle_h, telepod_circle_r-((5+telepod_step)*0.3));
*/
