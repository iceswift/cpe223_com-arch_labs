`timescale 1ns / 1ps

module branch_predictor_tb;

    // Inputs
    reg clk;
    reg rst;
    reg branch_taken;
    reg branch_not_taken;

    // Output
    wire prediction;

    // Instantiate the module
    branch_predictor dut (
        .clk(clk),
        .rst(rst),
        .branch_taken(branch_taken),
        .branch_not_taken(branch_not_taken),
        .prediction(prediction)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns period

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        branch_taken = 0;
        branch_not_taken = 0;

        #10;  // Wait for reset
        rst = 0;

        // Test sequence: demonstrate counts and prediction
        // Case 1: No branches yet -> predict 0 (taken=0, not=0)
        #10;

        // Case 2: Branch taken 2 times -> taken=2, not=0 -> predict 1
        branch_taken = 1; #10; branch_taken = 0;
        branch_taken = 1; #10; branch_taken = 0;

        // Case 3: Branch not taken 1 time -> taken=2, not=1 -> predict 1
        branch_not_taken = 1; #10; branch_not_taken = 0;

        // Case 4: Branch not taken 2 more times -> taken=2, not=3 -> predict 0
        branch_not_taken = 1; #10; branch_not_taken = 0;
        branch_not_taken = 1; #10; branch_not_taken = 0;

        // Case 5: Reset -> counts=0, predict 0
        rst = 1; #10; rst = 0;

        // End simulation
        #20;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%t | rst=%b | taken=%b | not_taken=%b | prediction=%b | taken_count=%d | not_taken_count=%d",
                 $time, rst, branch_taken, branch_not_taken, prediction, dut.taken_count, dut.not_taken_count);
    end

endmodule