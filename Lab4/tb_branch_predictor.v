module tb_branch_predictor;

reg clk;
reg reset;
reg branch_taken;
reg branch_not_taken;
wire branch_prediction;

branch_predictor uut (
    .clk(clk),
    .reset(reset),
    .branch_taken(branch_taken),
    .branch_not_taken(branch_not_taken),
    .branch_prediction(branch_prediction)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1;
    branch_taken = 0;
    branch_not_taken = 0;
    
    #20;
    reset = 1;
    #10;
    reset = 0;
    #10;
    
    branch_taken = 1;
    #10;
    branch_taken = 0;
    
    branch_taken = 1;
    #10;
    branch_taken = 0;
    
    branch_not_taken = 1;
    #10;
    branch_not_taken = 0;
    
    branch_not_taken = 1;
    #10;
    branch_not_taken = 0;
    
    branch_taken = 1;
    #10;
    branch_taken = 0;
    
    reset = 1;
    #10;
    reset = 0;
    
    #20;
    $display("All tests passed successfully!");
    $finish;
end

endmodule