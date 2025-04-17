module active (
    input  logic         clk,
    input  logic         rst_n,

    // DMA 接口
    input  logic [31:0]  dma_data,
    input  logic         dma_valid,

    // 输出
    output logic         bar_enabled
);

    // 激活码设定
    parameter logic [31:0] ACTIVATE_CODE = 32'hA5A5_FF00;

    logic         bar_enable_reg;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bar_enable_reg <= 1'b0;
        end else if (dma_valid) begin
            if (dma_data == ACTIVATE_CODE)
                bar_enable_reg <= 1'b1;
        end
    end

    assign bar_enabled = bar_enable_reg;

endmodule
