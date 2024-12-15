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

top_vertical_rail_position = 2;
bottom_rail_position = 2;
second_rail_above_grid = 0; // [0:3]
rails_variation = "horizontal"; // ["horizontal", "vertical", "cross"]


/* [Item Cutout] */

item_padding_left = 0;
item_padding_right = 0;
item_padding_bottom = 0;


/* [Hidden] */

multiboard_grid_offset = 25;
rail_position_offset = multiboard_grid_offset / 2;
multipoint_rail_depth = 2;
multipoint_rail_safe_zone = multipoint_rail_depth + back_wall;

tape_box_width = width + tolerance;
tape_box_depth = depth + tolerance;
tape_box_height = height + tolerance;

box_width = tape_box_width + 2 * side_walls;
box_depth = tape_box_depth + front_wall + multipoint_rail_safe_zone;
box_height = tape_box_height + bottom_wall;

cutout_width = tape_box_width - item_padding_left - item_padding_right;
cutout_height = tape_box_height - item_padding_bottom;
cutout_offset = side_walls + item_padding_right;
cutout_vertical_offset = box_height - tape_box_height + item_padding_bottom;

vertical_rail = rails_variation == "vertical";
rail_position = vertical_rail ? top_vertical_rail_position : bottom_rail_position; 
second_rail_distance = second_rail_above_grid * multiboard_grid_offset;
rails_width = (second_rail_above_grid > 0) ? second_rail_distance / 2 : 0;
vertical_top =  box_height - rail_position_offset - top_vertical_rail_position;
vertical_center_origin = box_width / 2;


module rail(position = bottom_rail_position, second = false, vertical = vertical_rail, all_rails_width = rails_width) {
    if (vertical) {
        translate([(position - top_vertical_rail_position) + vertical_center_origin - all_rails_width, 0, vertical_top]) {
        rotate([90, 0, 180]) {
                import("Lite Multipoint Rail - Negative.stl", $fn=100);
            }
        }
    } else {
        translate([0, 0, rail_position_offset + position]) {
            rotate([0, 90, 90]) {
                import("Lite Multipoint Rail - Negative.stl", $fn=100);
            }
        }
    }
}


difference() {
    union() {
        cube([box_width, box_depth - 5, box_height]);
    }
    union() {
        rail(rail_position);
        if (second_rail_above_grid > 0) {
            rail(rail_position + second_rail_distance, true);
        }
        if (rails_variation == "cross") {
            rail(top_vertical_rail_position, false, true, 0);
        }
        translate([side_walls, multipoint_rail_safe_zone, bottom_wall]) {
            cube([tape_box_width, tape_box_depth, tape_box_height]);
        }
        if (item_padding_left + item_padding_left + top_vertical_rail_position > 0) {
            translate([cutout_offset, box_depth - front_wall, cutout_vertical_offset]) {
                cube([cutout_width, front_wall, cutout_height]);
            }
        }
    }
}
