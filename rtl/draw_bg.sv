/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background.
 */


`timescale 1 ns / 1 ps

module draw_bg ( 
    vga_if.in vii, 
    vga_if.out vio,
    input  logic clk,
    input  logic rst
    );

    /*input  logic [10:0] vcount_in,
    input  logic        vsync_in,
    input  logic        vblnk_in,
    input  logic [10:0] hcount_in,
    input  logic        hsync_in,
    input  logic        hblnk_in,

    output logic [10:0] vcount_out,
    output logic        vsync_out,
    output logic        vblnk_out,
    output logic [10:0] hcount_out,
    output logic        hsync_out,
    output logic        hblnk_out,

    output logic [11:0] rgb_out
);
*/
import vga_pkg::*;


/**
 * Local variables and signals
 */

 vga_if vga_nxt ();


/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        vio.vcount <= '0;
        vio.vsync  <= '0;
        vio.vblnk  <= '0;
        vio.hcount <= '0;
        vio.hsync  <= '0;
        vio.hblnk  <= '0;
        vio.rgb    <= '0;
    end else begin
        vio.vcount <= vii.vcount;
        vio.vsync  <= vii.vsync;
        vio.vblnk  <= vii.vblnk;
        vio.hcount <= vii.hcount;
        vio.hsync  <= vii.hsync;
        vio.hblnk  <= vii.hblnk;
        vio.rgb    <= vga_nxt.rgb;
    end
end

always_comb begin : bg_comb_blk
    if (vii.vblnk || vii.hblnk) begin             // Blanking region:
        vga_nxt.rgb = 12'h0_0_0;                    // - make it it black.
    end else begin                              // Active region:
        if (vii.vcount == 0)                     // - top edge:
        vga_nxt.rgb = 12'hf_f_0;                // - - make a yellow line.
        else if (vii.vcount == VER_PIXELS - 1)   // - bottom edge:
        vga_nxt.rgb = 12'hf_0_0;                // - - make a red line.
        else if (vii.hcount == 0)                // - left edge:
        vga_nxt.rgb = 12'h0_f_0;                // - - make a green line.
        else if (vii.hcount == HOR_PIXELS - 1)   // - right edge:
        vga_nxt.rgb = 12'h0_0_f;                // - - make a blue line.
        else if (vii.vcount <= 500 && vii.vcount >= 100 && vii.hcount >= 50 && vii.hcount <= 54)
        vga_nxt.rgb = 12'h0_0_f; 
        else if (vii.vcount <= 104 && vii.vcount >= 100 && vii.hcount >= 54 && vii.hcount <= 200)
        vga_nxt.rgb = 12'h0_0_f; 
        else if (vii.vcount <= 204 && vii.vcount >= 200 && vii.hcount >= 54 && vii.hcount <= 200)
        vga_nxt.rgb = 12'h0_0_f;
        else if (vii.vcount <= 500 && vii.vcount >= 100 && vii.hcount >= 280 && vii.hcount <= 284)
        vga_nxt.rgb = 12'h0_0_f;
        else if ((vii.hcount - vii.vcount >= -100) && (vii.hcount - vii.vcount <= -96) && vii.hcount > 280 && vii.vcount < 500 )
        vga_nxt.rgb = 12'h0_0_f;
        else if ((-vii.hcount - vii.vcount >= -670) && (-vii.hcount - vii.vcount <= -666) && vii.hcount > 280 && vii.hcount < 414 )
        vga_nxt.rgb = 12'h0_0_f;
        else if (vii.vcount <= 500 && vii.vcount >= 100 && vii.hcount >= 580 && vii.hcount <= 584)
        vga_nxt.rgb = 12'h0_0_f;
        else if (vii.vcount <= 250 && vii.vcount >= 100 && vii.hcount >= 500 && vii.hcount <= 504)
        vga_nxt.rgb = 12'h0_0_f;  
        else if (vii.vcount <= 252 && vii.vcount >= 248 && vii.hcount >= 500 && vii.hcount <= 584) 
        vga_nxt.rgb = 12'h0_0_f;
        // Add your code here

        else                                    // The rest of active display pixels:
        vga_nxt.rgb = 12'h8_8_8;                // - fill with gray.
    end
end

endmodule
