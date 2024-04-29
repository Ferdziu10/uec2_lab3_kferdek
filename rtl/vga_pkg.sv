/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Package with vga related constants.
 */

package vga_pkg;

// Parameters for VGA Display 800 x 600 @ 60fps using a 40 MHz clock;
localparam HOR_PIXELS = 800;
localparam VER_PIXELS = 600;


// Add VGA timing parameters here and refer to them in other modules.
localparam HOR_FULL = 1056;
localparam VER_FULL = 628;

localparam HOR_BLNKSTR = 800;
localparam HOR_SYNCSTR = 840;
localparam HOR_SYNCSTP = 968;

localparam VER_BLNKSTR = 600;
localparam VER_SYNCSTR = 601;
localparam VER_SYNCSTP = 605;


// draw rct parameters
localparam X_RCTSTR = 100;
localparam Y_RCTSTR = 100;

localparam WID_RCT = 100;
localparam HGH_RCT = 200;

localparam COL_RCT = 12'hf_0_0;;




endpackage
