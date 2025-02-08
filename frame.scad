/*
 * Frame for mounting an SDS011 dust sensor and a NodeMCU into an
 * OBO Bettermann T60 box.
 *
 * (C) 2018 Richard "Shred" Körber
 *
 * Source code:
 *   https://codeberg.org/shred/dustycase
 *
 * Project page at PrusaPrinters:
 *   https://www.prusaprinters.org/prints/79784-particulates-sensor-case
 *
 * Licensed under Creative Commons BY-NC-SA:
 *   https://creativecommons.org/licenses/by-nc-sa/3.0/
 */



// Renders dummy components if set to true.
// Always set to false before exporting STL files!
DEBUG = true;



/* ==== CONFIGURATION ======================================================= */
// This part contains constants that are used for construction. They are not
// consequently used yet, so you might get a broken piece of plastic junk if
// you change any values.

// --- Platter Size ---
length              = 89.0;     // Maximum platter width
length_short        = 60.0;     // Length of each platter edge
thickness           =  3.0;     // Thickness of the platter
mounthole_radius    = 73.0 / 2; // Radius of mounting holes

// --- Inlet Pipes ---
// The T60 box is sold with M25 plug-in seals. If you cut them back to the outer
// ring (D6), a 19mm diameter pipe will fit into the seal. There is a distance
// of 32mm between two seals.
pipe_endFromCenter  = 57.0;     // Distance from box center to end of pipe
pipe_distance       = 32.0;     // Distance between the center of the pipes
pipe_length         = 15.0;     // Pipe length
pipe_extend_l       =  5.0;     // Additional length of left pipe
pipe_diameter       = 19.0;     // Diameter of the pipes

// --- Screws Holes ---
screw               =  3.0;     // Diameter of screw holes for piercing
screwhead           =  5.5;     // Diameter of screw heads
screwlength         = 10.0;     // Screw length
screwhole           =  3.0;     // Diameter of screw holes for mounting
screwcorners        =  5;       // Number of lines a screw hole consists of

// --- DHT22 Dimensions ---
dht22_height        = 15.5;     // Width
dht22_extra         =  1.3;

// --- MCU Dimensions ---
mcu_length          = 52.0;     // Distance between mounting holes, long edge
mcu_width           = 25.0;     // Distance between mounting holes, short edge

// --- SDS011 Dimensions ---
inlet_pos           = 70/2 - 20; // 70mm total, pipe 20mm from edge
inlet_hoseInnerDiam =  6.0;     // Inner diameter of inlet hose
inlet_diam          =  7.2;     // Inlet pipe diameter
inlet_maxOuterDiam  =  9.0;     // Maximum outside diameter of inlet hose
inhaust_len         = 17.0;     // Length of inlet pipe
sensorDist          = 37.0 - 2.0; // Distance from bottom plate to sensor PCB



/* ==== MAIN PARTS ========================================================== */
// For printing, alternately comment out each part, then render and export the
// STL file. (Remember to turn off DEBUG.)

// Renders the bottom part
lowerPart();

// Renders the top part
upperPart();



/* ==== NO USER SERVICABLE PARTS BELOW ;-) ================================== */

// Do some calculations...

length_platter = length - pipe_distance - pipe_diameter + dht22_extra/2;


/* ==== DUMMY COMPONENTS ==================================================== */

/*
 * Renders a DHT22 (temperature and humidity sensor).
 */
module dummy_DHT22() {
    color("white") translate([0, 0, 1.7/2]) difference() {
        union() {
            cube([25.1, 15.1, 1.7], center=true);
            translate([-(5.1/2), 0, 6/2]) cube([20.0, 15.1, 7.7], center=true);
        }
        translate([10.0 - 0.75 + 0.5, 0, -1]) {
            cylinder(d=3.0, h=7.7);
        }
    }
}

/*
 * Renders a Lolin NodeMCU.
 */
module dummy_NodeMCU() {
    translate([0, 14.0, 0]) {
        color("Green") {
            cube([31.25, 57.5, 13], center=true);
        }
        color("Black") rotate([0, 0, 90]) translate([-41, 0, -5]) {
            cube([25.0, 11, 7], center=true);
        }
    }
}

/*
 * Renders an SDS011 (particulates sensor).
 */
module dummy_SDS011() {
    // PCB
    color("LimeGreen") translate([0, 0, 1.0]) {
        difference() {
            cube([70.0, 70.0, 2.0], center=true);
            translate([30.0, 24.0, -1.5]) cylinder(d=3.2, h=3.0);
            translate([-30.0, 24.0, -1.5]) cylinder(d=3.2, h=3.0);
            translate([-11.0, -31.0, -1.5]) cylinder(d=3.2, h=3.0);
        }
    }

    // sensor box
    color("Silver") translate([0, 0, 2.0 + 6.0 - 0.1]) {
        difference() {
            translate([0, -2.5, 0]) cube([66.0, 58.0, 12.0], center=true);
            translate([30.0, 24.0, -2.0]) cube([8, 8, 18.0], center=true);
            translate([-30.0, 24.0, -2.0]) cube([8, 8, 18.0], center=true);
            translate([-21.0, -21.0, -2.0]) cube([26, 24, 18.0], center=true);
        }
        translate([-(70/2-20), 26, -1]) rotate([-90, 0, 0]) difference() {
            union() {
                intersection() {
                    cylinder(10.0, d=inlet_hoseInnerDiam);
                    cylinder(10.0, d1=inlet_hoseInnerDiam*1.5, d2=inlet_hoseInnerDiam*0.9);
                }
                translate([0, 0, 10.0 * 0.75 - 1])
                    cylinder(1, d1=inlet_hoseInnerDiam+0.8, d2=inlet_hoseInnerDiam);
                translate([0, 0, 10.0 * 0.50 - 1])
                    cylinder(1, d1=inlet_hoseInnerDiam+0.8, d2=inlet_hoseInnerDiam);
            }
            translate([0, 0, -0.25]) cylinder(10.0 + 0.5, d=4.0);
        }
    }

    // fan
    color("DarkSlateGray") translate([0, 0, 2.0 + 12.0 + 4.0 - 0.2]) {
        difference() {
            translate([13, -13, 0]) cube([35.0, 35.0, 8.0], center=true);
            translate([13, -15, -2.0]) cube([32.0, 32.0, 8.0], center=true);
        }
    }

    // shielding
    color("Silver") translate([0, 0, -1.75 + 0.1]) {
        translate([13.0, 11.0, 0]) cube([26.0, 26.0, 3.5], center=true);
    }
}



/* ==== LOWER PART ========================================================== */

/*
 * Lower Part materials to be added.
 */
module lowerPartAdd() {
    // base plate
    cube([length, length, thickness], center=true);

    // bolts for dust sensor
    rotate([0, 180, 90]) mirror([0, 0, 1]) {
        diam = 6.0;
        translate([-30.0, 24.0, -1.5]) cylinder(d=diam, h=sensorDist);
        translate([-11.0, -31.0, -1.5]) cylinder(d=diam, h=sensorDist);
    }

    // bolts for OpenMCU
    rotate([0, 180, 45]) translate([14.0, 0, 0]) mirror([0, 0, 1]) {
        dist = 9.0;
        diam = 6.0;
        translate([ mcu_length/2,  mcu_width/2, -thickness / 2]) cylinder(d=diam, h=dist);
        translate([-mcu_length/2,  mcu_width/2, -thickness / 2]) cylinder(d=diam, h=dist);
        translate([ mcu_length/2, -mcu_width/2, -thickness / 2]) cylinder(d=diam, h=dist);
        translate([-mcu_length/2, -mcu_width/2, -thickness / 2]) cylinder(d=diam, h=dist);
    }

    // bolts for BMP180
    translate([13.0, -45, 0]) rotate([0, 0, 90]) {
        dist = 6.0;
        diam = 6.0;
        bmpl = 14.5 / 2;
        bmpw = 9.0 / 2;
        translate([bmpl,  bmpw, thickness / 2]) cylinder(d=diam, h=dist);
        translate([bmpl, -bmpw, thickness / 2]) cylinder(d=diam, h=dist);
    }

    // inlet pipes
    {
        translate([0, pipe_endFromCenter - pipe_length, (pipe_diameter - thickness) / 2]) rotate([-90, 0, 0]) {
            translate([-pipe_distance / 2, 0, 0]) cylinder(pipe_length, d=pipe_diameter);
            translate([pipe_distance / 2, 0, -pipe_extend_l]) cylinder(pipe_length + pipe_extend_l, d=pipe_diameter);
        }
    }

    // wind tunnel
    {
        difference() {
            linear_extrude(height=(dht22_height + thickness/2)) polygon([
                [-(pipe_distance - pipe_diameter - dht22_extra)/2, length/2],
                [-(pipe_distance - pipe_diameter - dht22_extra)/2, 25.0],
                [-(length/2 - 10.0), 8.0],
                [-(length/2), 8.0],
                [-(length/2), 20.0],
                [-(length/2), length/2],
                [-(pipe_distance + pipe_diameter - dht22_extra)/2, length/2],
            ]);
            linear_extrude(height=(dht22_height + thickness/2 + 0.5)) polygon([
                [-(pipe_distance - pipe_diameter)/2 - 3.0, length/2 - 5.0],
                [-(pipe_distance - pipe_diameter)/2 - 3.0, 33.0],
                [-(length/2 - 10.0), inlet_pos - inlet_diam/2],
                [-(length/2 - 3.0), inlet_pos - inlet_diam/2],
                [-(length/2 - 3.0), inlet_pos + inlet_diam/2],
                [-(length/2 - 10.0), inlet_pos + inlet_diam/2],
                [-(pipe_distance + pipe_diameter)/2 + 3.0, 27.0],
                [-(pipe_distance + pipe_diameter)/2 + 3.0, length/2 - 5.0],
            ]);
        }
    }

    // stabilizer
    stabWidth = length_platter;
    stabThick = 3.0;
    translate([-(length - stabWidth)/2, -(length - stabThick)/2, (dht22_height + thickness)/2]) {
        cube([stabWidth, stabThick, dht22_height], center=true);
        rotate([0,0,45]) translate([0, 10, 0]) cube([10, 37, dht22_height], center=true);
    }
    translate([-(length - stabThick)/2, -(length - stabWidth)/2, (dht22_height + thickness)/2]) {
        cube([stabThick, stabWidth, dht22_height], center=true);
    }

    // dust apron
    translate([31.0 - 4.5, -12.0, 11.0 - thickness / 2]) {
        cube([9.0, 48.0, 22.0], center=true);
    }

    // DHT22 back
    translate([-10.5, 17, (dht22_height + thickness) / 2]) rotate([0, 0, 45]) {
        cube([20.0, 3.0, dht22_height], center=true);
    }
}

/*
 * Lower Part materials to be subtracted.
 */
module lowerPartSub() {
    // mounting holes
    translate([-mounthole_radius, 0, 0]) cylinder(thickness+1, d=screw, center=true);
    translate([ mounthole_radius, 0, 0]) cylinder(thickness+1, d=screw, center=true);
    translate([0, -mounthole_radius, 0]) cylinder(thickness+1, d=screw, center=true);
    translate([0,  mounthole_radius, 0]) cylinder(thickness+1, d=screw, center=true);
    translate([-mounthole_radius, 0, (thickness - 1.4) / 2]) cylinder(1.5, d1=screw, d2=screwhead, center=true);
    translate([ mounthole_radius, 0, (thickness - 1.4) / 2]) cylinder(1.5, d1=screw, d2=screwhead, center=true);
    translate([0, -mounthole_radius, (thickness - 1.4) / 2]) cylinder(1.5, d1=screw, d2=screwhead, center=true);
    translate([0,  mounthole_radius, (thickness - 1.4) / 2]) cylinder(1.5, d1=screw, d2=screwhead, center=true);

    // corners
    translate([-length/2, -length/2, 0]) cylinder(100, d=length-length_short, center=true);
    translate([ length/2, -length/2, 0]) cylinder(thickness+1, d=length-length_short, center=true);
    translate([-length/2,  length/2, 0]) cylinder(100, d=length-length_short, center=true);
    translate([ length/2,  length/2, 0]) cylinder(thickness+1, d=length-length_short, center=true);

    // drill holes for bolts dust sensor
    rotate([0, 180, 90]) mirror([0, 0, 1]) translate([0, 0, 37.0 - 2.0 - screwlength]) {
        translate([-30.0, 24.0, 0]) cylinder(d=screwhole, h=screwlength, $fn=screwcorners);
        translate([-11.0, -31.0, 0]) cylinder(d=screwhole, h=screwlength, $fn=screwcorners);
    }

    // drill holes for OpenMCU
    rotate([0, 180, 45]) translate([14.0, 0, 0]) mirror([0, 0, 1]) translate([0, 0, 9.0 - screwlength]){
        translate([ mcu_length/2,  mcu_width/2, 0]) cylinder(d=screwhole, h=screwlength, $fn=screwcorners);
        translate([-mcu_length/2,  mcu_width/2, 0]) cylinder(d=screwhole, h=screwlength, $fn=screwcorners);
        translate([ mcu_length/2, -mcu_width/2, 0]) cylinder(d=screwhole, h=screwlength, $fn=screwcorners);
        translate([-mcu_length/2, -mcu_width/2, 0]) cylinder(d=screwhole, h=screwlength, $fn=screwcorners);
    }

    // pin strip opening for OpenMCU
    rotate([180, 180, 45]) translate([14.0, 0, thickness / 2 - 0.5]) {
        cube([40.0, 32.0, thickness * 2], center=true);
    }

    // drill holes for BMP180
    translate([13.0, -45, -2]) rotate([0, 0, 90]) {
        dist = 6.0;
        diam = 6.0;
        bmpl = 14.5 / 2;
        bmpw = (13.75 - 5.0) / 2;
        translate([bmpl,  bmpw, thickness / 2]) cylinder(d=screwhole, h=screwlength, $fn=screwcorners);
        translate([bmpl, -bmpw, thickness / 2]) cylinder(d=screwhole, h=screwlength, $fn=screwcorners);
    }

    // pin strip opening for BMP180
    rotate([180, 180, 0]) translate([-13, 27, thickness / 2 - 0.5]) {
        cube([16.0, 12.0, thickness * 2], center=true);
    }

    // dust apron
    translate([31.0 - 4.5 - 1.6, -12.0, 11.0 + thickness / 2]) {
        cube([9.0 - 3.0, 48.0 - 3.0 - 3.0, 22.0], center=true);
    }
    translate([31.0, -13.0, 15.1 + thickness / 2]) {
        cube([10.0 - 3.0, 36.0, 8.0], center=true);
    }

    // inlet pipes
    translate([0, pipe_endFromCenter - pipe_length, (pipe_diameter - thickness) / 2]) rotate([-90, 0, 0]) {
        translate([-pipe_distance / 2, 0, -3.5]) difference() {
            cylinder(pipe_length + 10.0, d=pipe_diameter-thickness*2);
            for (i = [-pipe_diameter/2:3:pipe_diameter/2]) {
                translate([i, 0, pipe_length - 1]) cube([2, pipe_diameter, 5], center=true);
                translate([i+1.5, 0, pipe_length - 8]) cube([2, pipe_diameter, 5], center=true);
            }
        }
        translate([pipe_distance / 2, 0, -2.5-pipe_extend_l]) difference() {
            cylinder(pipe_length + pipe_extend_l + 10.0, d=pipe_diameter-thickness*2);
            for (i = [-pipe_diameter/2:3:pipe_diameter/2]) {
                translate([i, 0, pipe_length + pipe_extend_l - 1 - 1]) cube([2, pipe_diameter, 5], center=true);
                translate([i+1.5, 0, pipe_length + pipe_extend_l - 1 - 10]) cube([2, pipe_diameter, 8], center=true);
            }
        }
    }

    // wind tunnel mounting drill holes
    translate([-34, 27, dht22_height - screwlength + thickness/2 + 0.2]) cylinder(d=screwhole, h=screwlength, $fn=screwcorners);
    translate([-27, -40, dht22_height - screwlength + thickness/2 + 0.2]) cylinder(d=screwhole, h=screwlength, $fn=screwcorners);

    // stabilizer
    translate([-(length + 10)/2, 0, -0.5]) cube([10, length, 100], center=true);
    translate([0, -(length + 10)/2, -0.5]) cube([length, 10, 100], center=true);

    // DHT22 opening
    translate([-18, 24.5, (dht22_height + 2 + thickness)/2]) rotate([0, 0, 45]) {
        cube([15.0, 5.0, dht22_height + 2], center=true);
    }
    translate([-10, 20, (dht22_height + 2 + thickness)/2]) rotate([90, 180, 45 + 180]) {
        translate([0, 0, 1.7/2]) translate([-(5.1/2), 0, 6/2]) cube([21, dht22_height + 2, 7.7], center=true);
    }
}

/*
 * Construct the lower part.
 */
module lowerPart() {
    translate([0, 0, thickness/2]) {
        difference() {       // How do you carve an elephant?
            lowerPartAdd();    // Get a block of wood, and then just
            lowerPartSub();    // cut away what does not look like an elephant.
        }
    }
}



/* ==== UPPER PART ========================================================== */

/*
 * Upper Part materials to be added.
 */
module upperPartAdd() {
    // base plate
    translate([-(length - length_platter)/2, 0, 0]) {
        cube([length_platter, length, thickness], center=true);
    }

    // bolts for dust sensor
    rotate([0, 180, 90]) mirror([0, 0, 1]) {
        diam = 6.0;
        translate([30.0, 24.0, -1.5]) cylinder(d=diam, h=sensorDist-dht22_height-thickness);
    }

    // inhaust
    inhaust_height = sensorDist - dht22_height - thickness;
    translate([-(length-inhaust_len)/2, inlet_pos, (inhaust_height-thickness)/2]) {
        cube([inhaust_len, inlet_maxOuterDiam, inhaust_height], center=true);
    }
}

/*
 * Upper Part materials to be subtracted.
 */
module upperPartSub() {
    // corners
    translate([-length/2, -length/2, 0]) cylinder(100, d=length-length_short, center=true);
    translate([ length/2, -length/2, 0]) cylinder(thickness+1, d=length-length_short, center=true);
    translate([-length/2,  length/2, 0]) cylinder(100, d=length-length_short, center=true);
    translate([ length/2,  length/2, 0]) cylinder(thickness+1, d=length-length_short, center=true);

    // drill holes for bolts dust sensor
    rotate([0, 180, 90]) mirror([0, 0, 1]) translate([0, 0, 37.0 - dht22_height - thickness - 2.0 - screwlength]) {
        translate([30.0, 24.0, 0]) cylinder(d=screwhole, h=screwlength, $fn=screwcorners);
    }

    // inhaust
    translate([-(length-inhaust_len)/2 + thickness, inlet_pos, 10.0]) {
        rotate([0, 90, 0]) translate([0, 0, -inhaust_len/2]) cylinder(h=inhaust_len + 1.0, d=inlet_diam);
        translate([2, 0, 3.6]) cube([8.4, inlet_diam, inlet_diam], center=true);
        translate([-4.9, 0, -7]) cube([inlet_diam, inlet_diam, 14], center=true);
    }

    // wind tunnel mounting drill holes
    translate([-34, 27, -thickness-1]) cylinder(d=screwhole, h=20.0);
    translate([-27, -40, -thickness-1]) cylinder(d=screwhole, h=20.0);
    translate([-34, 27, (thickness - 1.4) / 2]) cylinder(1.5, d1=screw, d2=screwhead, center=true);
    translate([-27, -40, (thickness - 1.4) / 2]) cylinder(1.5, d1=screw, d2=screwhead, center=true);

    // hole for bolt dust sensor
    rotate([0, 180, 90]) mirror([0, 0, 1]) {
        diam = 6.0;
        translate([-30.0, 24.0, -(sensorDist/2+1.5)]) cylinder(d=diam + 0.5, h=sensorDist);
    }

    // cutout for air inlet
    translate([-(pipe_distance)/2, length/2, -thickness/2 - 0.5]) cube([7, 6, 10], center=true);
}

/*
 * Construct the upper part.
 */
module upperPart() {
    color("orange") translate([0, 0, dht22_height + thickness*1.5]) {
        difference() {
            upperPartAdd();
            upperPartSub();
        }
    }
}



/* ==== DEBUGGING =========================================================== */

/*
 * Render dummy components if DEBUG is enabled.
 */
if (DEBUG) {
    translate([0.0, 0.0, 37.0]) rotate([0, 180, 90]) dummy_SDS011();
    translate([0.0, 0.0, 6.5]) rotate([0, 180, 135]) dummy_NodeMCU();
    translate([-10, 20, 15.1/2 + thickness]) rotate([90, 180, 45 + 180]) dummy_DHT22();
}


$fn = 180;
