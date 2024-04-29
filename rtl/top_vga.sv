/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic rst,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);


/**
 * Local variables and signals
 

// VGA signals from timing
wire [10:0] vcount_tim, hcount_tim;
wire vsync_tim, hsync_tim;
wire vblnk_tim, hblnk_tim;

// VGA signals from background
wire [10:0] vcount_bg, hcount_bg;
wire vsync_bg, hsync_bg;
wire vblnk_bg, hblnk_bg;
wire [11:0] rgb_bg;

// VGA signals from rct
wire [10:0] vcount_rc, hcount_rc;
wire vsync_rc, hsync_rc;
wire vblnk_rc, hblnk_rc;
wire [11:0] rgb_rc;
*/
vga_if vga_tim();
vga_if vga_bg();
vga_if vga_rc();

/**
 * Signals assignments
 */

assign vs = vga_rc.vsync;
assign hs = vga_rc.hsync;
assign {r,g,b} = vga_rc.rgb;


/**
 * Submodules instances
 */

vga_timing u_vga_timing (
    .clk,
    .rst,
    .vio (vga_tim)
);

draw_bg u_draw_bg (
    .clk,
    .rst,

    .vii (vga_tim),
    .vio (vga_bg)

);

draw_rct u_draw_rct (
    .clk,
    .rst,

    .vii (vga_bg),
    .vio (vga_rc)
);


endmodule
