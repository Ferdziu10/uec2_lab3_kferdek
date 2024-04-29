interface vga_if;
    logic [10:0] vcount;
    logic [10:0] hcount;
    logic vblnk;
    logic hblnk;
    logic vsync;
    logic hsync;
    logic [11:0] rgb;

    modport in (
        input vcount, hcount, vblnk, hblnk, vsync, hsync, rgb
    );
    modport out (
        output vcount, hcount, vblnk, hblnk, vsync, hsync, rgb
    );
endinterface
