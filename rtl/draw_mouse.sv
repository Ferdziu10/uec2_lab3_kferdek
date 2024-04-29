module draw_mouse (
    vga_if.in vii, 
    vga_if.out vio,
    input  logic [11:0] xpos,
    input  logic [11:0] ypos,
    input  logic clk,
    input  logic rst 
    );
    import vga_pkg::*;
 /* Local variables and signals
 */

 wire enable_mouse_display_out;

 MouseDisplay u_MouseDisplay (
    .xpos,
    .ypos,
    .pixel_clk (clk),
    .hcount (vii.hcount),
    .vcount (vii.vcount),
    .blank (vii.hblnk | vii.vblnk),
    .rgb_in (vii.rgb),
    .rgb_out (vio.rgb),
    .enable_mouse_display_out ()
 );




always_ff @(posedge clk) begin 
        if (rst) begin
            vio.vcount <= '0;
            vio.vsync  <= '0;
            vio.vblnk  <= '0;
            vio.hcount <= '0;
            vio.hsync  <= '0;
            vio.hblnk  <= '0;
        end else begin
            vio.vcount <= vii.vcount;
            vio.vsync  <= vii.vsync;
            vio.vblnk  <= vii.vblnk;
            vio.hcount <= vii.hcount;
            vio.hsync  <= vii.hsync;
            vio.hblnk  <= vii.hblnk;
        end
    end
endmodule
