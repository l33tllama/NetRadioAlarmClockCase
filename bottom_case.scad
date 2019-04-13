case_width = 230;
case_depth = 100;
bottom_rim = 15;
wall_thickness=2;
screw_head_diameter=5;
screw_diameter=3;

module screw_cylinder_bot(pos){
    translate(pos)
    difference(){
        cylinder(h=bottom_rim-wall_thickness, r=screw_head_diameter/2+1, $fn=16);
        cylinder(h=bottom_rim-wall_thickness, r=screw_diameter/2+0.1, $fn=8);
        cylinder(h=bottom_rim-wall_thickness-3,r=screw_head_diameter/2+0.1, $fn=16);
    }
}

module screw_hole_bot(pos){
    translate(pos)
        cylinder(h=wall_thickness, r=screw_head_diameter/2+0.1, $fn=16);
}

module vol_knob_support(x, z){
    translate([4.65 * x, 0, 4.65 * z])
        rotate([-90, 0, 0])
            cylinder(r=0.5,h=wall_thickness);
}
    

translate([wall_thickness, wall_thickness, 0])
    difference(){
        
        cube([case_width-wall_thickness*2, case_depth-wall_thickness*2, bottom_rim]);
        
        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([case_width-wall_thickness*4, case_depth-wall_thickness*4,bottom_rim]);
        
        // Bottom holes for screw heads
        // Front left
        screw_hole_bot([wall_thickness + screw_head_diameter/2 , wall_thickness + screw_head_diameter/2 , 0]);
        
        // Front right
        screw_hole_bot([case_width - wall_thickness*3 - screw_head_diameter/2, wall_thickness + screw_head_diameter/2, 0]);
        
        // Rear left
        screw_hole_bot([wall_thickness + screw_head_diameter/2, case_depth - wall_thickness*3 - screw_head_diameter/2, 0]);
        
        // Rear right
        screw_hole_bot([case_width - wall_thickness*3 - screw_head_diameter/2,case_depth - wall_thickness*3 - screw_head_diameter/2, 0]);
    }
    
    // Screw posts
    // Front left
    screw_cylinder_bot([wall_thickness*2 + screw_head_diameter/2, wall_thickness*2 + screw_head_diameter/2,wall_thickness]);
    
    // Front right
    screw_cylinder_bot([case_width-wall_thickness*2-screw_head_diameter/2, wall_thickness*2 + screw_head_diameter/2, wall_thickness]);
    
    // Rear left
    screw_cylinder_bot([wall_thickness*2 + screw_head_diameter/2, case_depth - wall_thickness*2 - screw_head_diameter/2, wall_thickness]);
    
    // Rear right
    screw_cylinder_bot([case_width-wall_thickness*2-screw_head_diameter/2, case_depth - wall_thickness*2 - screw_head_diameter/2, wall_thickness]);
    
    vol_support_x = 60;
    vol_support_z = 25;
    translate([case_width/2-vol_support_x/2, wall_thickness, 0])
    difference(){
        cube([vol_support_x, wall_thickness, vol_support_z+bottom_rim]);
        translate([vol_support_x/2, 0, bottom_rim + vol_support_z/2]){
            rotate([-90, 0, 0])
                cylinder(r=3.5, h=wall_thickness, $fn=14);
            
            vol_knob_support(-1, -1);
            vol_knob_support(1, -1);
            vol_knob_support(1, 1);
            vol_knob_support(-1, 1);
        }
            
        
            
    }
    
    