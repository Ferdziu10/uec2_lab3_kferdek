`timescale 1 ns / 1 ps

module draw_rct (
    vga_if.in vii, 
    vga_if.out vio,
    input  logic clk,
    input  logic rst
    );
    import vga_pkg::*;
 /* Local variables and signals
 */

 vga_if vga_nxt ();

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


always_comb begin
    if ( vii.hcount >= X_RCTSTR && vii.hcount <= X_RCTSTR + WID_RCT && vii.vcount >= Y_RCTSTR && vii.vcount <= Y_RCTSTR + HGH_RCT )
    vga_nxt.rgb = COL_RCT;
/*
    else if ( vcount_in >= X_RCTSTR && vcount_in <= X_RCTSTR + WID_RCT && hcount_in == Y_RCTSTR + HGH_RCT )
        rgb_nxt = COL_RCT;
    else if ( hcount_in >= Y_RCTSTR && hcount_in <= Y_RCTSTR + HGH_RCT && vcount_in == X_RCTSTR + WID_RCT )
        rgb_nxt = COL_RCT;
    else if ( hcount_in >= Y_RCTSTR && hcount_in <= Y_RCTSTR + HGH_RCT && vcount_in == X_RCTSTR )
        rgb_nxt = COL_RCT;
*/
    else 
    vga_nxt.rgb = vii.rgb;
end
endmodule