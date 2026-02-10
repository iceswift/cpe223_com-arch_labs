module branch_predictor (
    input clk,
    input rst,
    input branch_taken,
    input branch_not_taken,
    output prediction
);

    // Internal registers: 32-bit unsigned for counts
    reg [31:0] taken_count;
    reg [31:0] not_taken_count;

    // Sequential logic on clock edge
    always @(posedge clk) begin
        if (rst) begin
            taken_count <= 32'd0;
            not_taken_count <= 32'd0;  // Reset to 0
        end else begin
            if (branch_taken) begin
                taken_count <= taken_count + 1;  // Increment taken count
            end else if (branch_not_taken) begin
                not_taken_count <= not_taken_count + 1;  // Increment not taken count
            end
        end
    end

    // Combinational output: predict taken if taken_count > not_taken_count
    assign prediction = (taken_count > not_taken_count) ? 1'b1 : 1'b0;

endmodule