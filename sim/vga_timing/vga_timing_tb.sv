/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Testbench for vga_timing module.
 */

`timescale 1 ns / 1 ps

module vga_timing_tb;

import vga_pkg::*;


/**
 *  Local parameters
 */

localparam CLK_PERIOD = 25;     // 40 MHz


/**
 * Local variables and signals
 */

logic clk;
logic rst;
vga_if vio();


/**
 * Clock generation
 */

initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


/**
 * Reset generation
 */

initial begin
                       rst = 1'b0;
    #(1.25*CLK_PERIOD) rst = 1'b1;
                       rst = 1'b1;
    #(2.00*CLK_PERIOD) rst = 1'b0;
end


/**
 * Dut placement
 */

vga_timing dut(
    .clk,
    .rst,
    .vio
);

/**
 * Tasks and functions
 */

 // Here you can declare tasks with immediate assertions (assert).

/**
 * Assertions
 */

// Here you can declare concurrent assertions (assert property).
assert property (@(posedge clk) vio.hcount<=1055) $display("OK! Hcount value is lower than 1055");
    else $error("Error! Hcount value is higher than 1055");
assert property (@(posedge clk) vio.vcount<=628) $display("OK! Vcount value is lower than 1055");
    else $error("Error! Vcount value is higher than 1055");
/**
 * Main test
 */

initial begin
    @(posedge rst);
    @(negedge rst);

    wait (vio.vsync == 1'b0);
    @(negedge vio.vsync)
    @(negedge vio.vsync)

    $finish;
end

endmodule
