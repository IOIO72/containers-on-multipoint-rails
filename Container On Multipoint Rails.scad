// Brother P-Touch Tapes Holder On Multipoint Rails

/* [Tape Box] */

width = 17;
depth = 68;
height = 40;
tolerance = 2;


/* [Walls] */

side_walls = 0.8;
front_wall = 1.2;
back_wall = 1.8;
bottom_wall = 1.4;


/* [Rail Position] */

bottom_rail_position = 2;
second_rail_above_grid = 0; // [0:3]


/* [Hidden] */

multiboard_grid_offset = 20;
rail_position_offset = multiboard_grid_offset / 2;
multipoint_rail_depth = 2;
multipoint_rail_safe_zone = multipoint_rail_depth + back_wall;

tape_box_width = width + tolerance;
tape_box_depth = depth + tolerance;
tape_box_height = height + tolerance;

box_width = tape_box_width + 2 * side_walls;
box_depth = tape_box_depth + front_wall + multipoint_rail_safe_zone;
box_height = tape_box_height + bottom_wall;


module rail(position = bottom_rail_position) {
    translate([0, 0, rail_position_offset + position]) {
        rotate([0, 90, 90]) {
            import("Lite Multipoint Rail - Negative.stl", $fn=100);
        }
    }
}


difference() {
    union() {
        cube([box_width, box_depth, box_height]);
    }
    union() {
        rail(bottom_rail_position);
        if (second_rail_above_grid > 0) {
            rail(bottom_rail_position + second_rail_above_grid * multiboard_grid_offset);
        }
        translate([side_walls, multipoint_rail_safe_zone, bottom_wall]) {
            cube([tape_box_width, tape_box_depth, tape_box_height]);
        }
    }
}
