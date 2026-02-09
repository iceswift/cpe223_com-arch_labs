module branch_predictor (
    input  clk,
    input  reset,
    input  branch_taken,
    input  branch_not_taken,
    output reg branch_prediction
);

reg [31:0] taken_count;
reg [31:0] not_taken_count;

always @(posedge clk) begin
    if (reset) begin
        taken_count <= 32'd0;
        not_taken_count <= 32'd0;
    end
    else begin
        if (branch_taken)
            taken_count <= taken_count + 1;
        if (branch_not_taken)
            not_taken_count <= not_taken_count + 1;
    end
end

assign branch_prediction = (taken_count > not_taken_count);

endmodule