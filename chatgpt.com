module pipeline_cpu(input clk, reset);
// IF stage
wire [31:0] pc, instr;
IFStage ifs(.clk(clk), .reset(reset), .pc_out(pc), .instr(instr));

// IF/ID register
wire [31:0] pc_id, instr_id;
IF_ID if_id(.clk(clk), .in_pc(pc), .in_instr(instr), .out_pc(pc_id), .out_instr(instr_id));

// ID stage
wire [4:0] rs1, rs2, rd;
wire [31:0] reg_data1, reg_data2;
Control ctrl(.instr(instr_id), …);
RegFile rf(.clk(clk), .writes(...), .rs1(instr_id[19:15]), mp);

// ID/EX, EX, EX/WB, WB -- similarly…
endmodule
