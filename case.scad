
case_width = 230;
case_depth = 100;
case_height = 90;
bottom_rim = 15;
wall_thickness = 2;
lcd_width = 77;
lcd_height = 50;
top_margin = 15;
bottom_margin = 3;
speaker_dims = 53;
speaker_hole = 49;
speaker_gap = 15;
screw_diameter=3;
spkr_hole_spacing=4.4;
knob_diameter = 30;
screw_cylinder_diameter=13;
screw_head_diameter=5;
bottom_inset=10;

module top_lid() {
    difference(){
        cube([case_width, case_depth, case_height]);
        translate([wall_thickness, wall_thickness, -wall_thickness])
            cube([case_width-2*wall_thickness, case_depth-2*wall_thickness, case_height]);
    }
}

module speaker(x_pos){
    translate([x_pos,0, case_height-top_margin-speaker_dims/2])
        rotate([-90, 0, 0])
            cylinder(h=wall_thickness*2, r=speaker_hole/2, $fn=40);
}

module screw_hole(x_pos, z_pos){
    translate([x_pos, -wall_thickness, z_pos])
        rotate([-90, 0, 0])
            cylinder(h=wall_thickness*2, r=screw_diameter/2, $fn=12);
}

module volume_knob_inset(){
    
    translate([case_width/2, 0, -bottom_rim + knob_diameter/2 + bottom_margin])
        rotate([-90, 0, 0])
            cylinder(h=wall_thickness*2, r=knob_diameter/2, $fn=20);
}

module screw_cylinder(position){
    translate(position)
        translate([0, 0, bottom_rim+bottom_inset])
            difference(){
                //case_height-wall_thickness-bottom_inset
                cylinder(h=12, r=screw_cylinder_diameter/2, $fn=14);
                cylinder(h=10, r=screw_diameter/2, $fn=16);
            }
}

translate([0, 0, bottom_rim])
    difference(){
        // Top lid inc difference
        top_lid();
        
        // LCD
        translate([(case_width/2) - (lcd_width/2), 0,case_height-top_margin-lcd_height])
            cube([lcd_width, wall_thickness, lcd_height]);
        
        // Speakers
        left_spkr_x = (case_width/2)-(lcd_width/2)-speaker_dims/2-speaker_gap;
        right_spkr_x = (case_width/2)+(lcd_width/2)+speaker_dims/2+speaker_gap;
        spkr_z = case_height-top_margin-speaker_dims/2;
        speaker(left_spkr_x);
        speaker(right_spkr_x);
        
        // Speaker screw holes
        // Left
        // Left bottom left
        screw_hole(left_spkr_x - speaker_dims/2 + screw_diameter/2 + spkr_hole_spacing, spkr_z - speaker_dims/2 + screw_diameter/2 + spkr_hole_spacing);
        // Left top left
        screw_hole(left_spkr_x - speaker_dims/2 + screw_diameter/2 + spkr_hole_spacing, spkr_z + speaker_dims/2 - screw_diameter/2 - spkr_hole_spacing);
        // Left top right
        screw_hole(left_spkr_x + speaker_dims/2 - screw_diameter/2 - spkr_hole_spacing, spkr_z + speaker_dims/2 - screw_diameter/2 - spkr_hole_spacing);
        // Left bottom right
        screw_hole(left_spkr_x + speaker_dims/2 - screw_diameter/2 - spkr_hole_spacing, spkr_z - speaker_dims/2 + screw_diameter/2 + spkr_hole_spacing);
        
        // Right
        // Right bottom left
        screw_hole(right_spkr_x - speaker_dims/2 + screw_diameter/2 + spkr_hole_spacing, spkr_z - speaker_dims/2 + screw_diameter/2 + spkr_hole_spacing);
        // Right top left
        screw_hole(right_spkr_x - speaker_dims/2 + screw_diameter/2 + spkr_hole_spacing, spkr_z + speaker_dims/2 - screw_diameter/2 - spkr_hole_spacing);
        // Right top right
        screw_hole(right_spkr_x + speaker_dims/2 - screw_diameter/2 - spkr_hole_spacing, spkr_z + speaker_dims/2 - screw_diameter/2 - spkr_hole_spacing);
        // Right bottom right
        screw_hole(right_spkr_x + speaker_dims/2 - screw_diameter/2 - spkr_hole_spacing, spkr_z - speaker_dims/2 + screw_diameter/2 + spkr_hole_spacing);
        
        // Volume knob inset
        volume_knob_inset();
        
        
    }
    // Screw cylinders
    // Front left
    screw_cylinder([wall_thickness*2 + screw_head_diameter/2, wall_thickness*2 + screw_head_diameter/2, 0]);
    // Front right
    screw_cylinder([case_width-screw_head_diameter/2 - wall_thickness*2, wall_thickness*2+screw_head_diameter/2, 0]);
    // Rear left
    screw_cylinder([wall_thickness*2 + screw_head_diameter/2, case_depth-screw_head_diameter/2-wall_thickness*2, 0]);
    // Rear right
    screw_cylinder([case_width-screw_head_diameter/2 - wall_thickness*2, case_depth-screw_head_diameter/2-wall_thickness*2, 0]);
    
    
    