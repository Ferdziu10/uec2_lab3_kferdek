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
    input  logic clk100MHz,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b,
    inout  logic ps2_clk,
    inout  logic ps2_data
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

wire [11:0] xpos;
wire [11:0] ypos;
wire [11:0] xpos_M;
wire [11:0] ypos_M;


vga_if vga_tim();
vga_if vga_bg();
vga_if vga_rc();
vga_if vga_ms();

/**
 * Signals assignments
 */

assign vs = vga_ms.vsync;
assign hs = vga_ms.hsync;
assign {r,g,b} = vga_ms.rgb;


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

    .xpos,
    .ypos,

    .vii (vga_bg),
    .vio (vga_rc)
);

MouseCtl u_MouseCtl (
    .clk (clk100MHz),
    .ps2_clk (ps2_clk),
    .ps2_data (ps2_data),
    .rst,
    .xpos (xpos_M),
    .ypos (ypos_M),
    .zpos (),
    .value ('0),
    .left (),
    .middle (),
    .new_event (), 
    .right (),
    .setmax_x ('0),
    .setmax_y ('0),
    .setx ('0),
    .sety ('0)
);
mouse_to40 u_mouse_to40(
    .xpos_in (xpos_M),
    .ypos_in (ypos_M),
    .xpos_out (xpos),
    .ypos_out (ypos),
    .clk,
    .rst
);

draw_mouse u_draw_mouse (
    .clk,
    .rst,

    .xpos,
    .ypos,

    .vii (vga_rc),
    .vio (vga_ms)
);


endmodule
