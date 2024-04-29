/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Vga timing controller.
 */

`timescale 1 ns / 1 ps

module vga_timing (
    input  logic clk,
    input  logic rst,
    vga_if.out vio
);

import vga_pkg::*;


/**
 * Local variables and signals
 

logic [10:0] vcount_nxt;
logic [10:0] hcount_nxt;
logic  vsync_nxt;
logic  vblnk_nxt;
logic  hsync_nxt;
logic  hblnk_nxt;
*/
 vga_if vga_nxt ();


/**
 * Internal logic
 */

always_ff @(posedge clk) begin
    if (rst) begin
        vio.vcount <= '0;
        vio.hcount <= '0;
        vio.vsync <= '0;
        vio.vblnk <= '0;
        vio.hsync <= '0;
        vio.hblnk <= '0;
    end else begin 
        vio.vcount <= vga_nxt.vcount;
        vio.hcount <= vga_nxt.hcount;
        vio.vsync <= vga_nxt.vsync;
        vio.vblnk <= vga_nxt.vblnk;
        vio.hsync <= vga_nxt.hsync;
        vio.hblnk <= vga_nxt.hblnk;
    end
end

always_comb begin
    if ((vio.hcount == HOR_FULL-1) && (vio.vcount == VER_FULL-1)) begin
        vga_nxt.vcount = '0;
        vga_nxt.hcount = '0;
        end 
    else if (vio.hcount == HOR_FULL-1) begin
        vga_nxt.hcount = '0;
        vga_nxt.vcount = vio.vcount + 1;
        end 
    else begin
        vga_nxt.hcount = vio.hcount + 1;
        vga_nxt.vcount = vio.vcount;
        end
    if (vga_nxt.hcount <= HOR_BLNKSTR-1) begin
        vga_nxt.hsync = '0;
        vga_nxt.hblnk = '0;
    end else if (vga_nxt.hcount <= HOR_SYNCSTR-1) begin
        vga_nxt.hsync = '0;
        vga_nxt.hblnk = 1;
    end else if (vga_nxt.hcount <= HOR_SYNCSTP-1) begin
        vga_nxt.hsync = 1;
        vga_nxt.hblnk = 1;
    end else begin
        vga_nxt.hsync = '0;
        vga_nxt.hblnk = 1;
    end
    if (vga_nxt.vcount <= VER_BLNKSTR-1) begin
        vga_nxt.vsync = '0;
        vga_nxt.vblnk = '0;
    end else  if (vga_nxt.vcount <= VER_SYNCSTR-1) begin
        vga_nxt.vsync = '0;
        vga_nxt.vblnk = 1;
    end else  if (vga_nxt.vcount <= VER_SYNCSTP-1) begin
        vga_nxt.vsync = 1;
        vga_nxt.vblnk = 1;
    end else begin
        vga_nxt.vsync = '0;
        vga_nxt.vblnk = 1;
    end
end





endmodule
