module processor_top(input clk, enable, input [31:0] instr_in);
//------------------------------------IF Stage-------------------------------------------------------
wire [31:0] w_branch_addr, w_addr;
wire [31:0] instr_ifid_w, pc4_ifid_w, next_instr_ifid_idex_w, regMux_register_w, d1_reg_idEX_w, d2_reg_idEX_w, signExt_idEX_w;
wire [31:0] data1_idex_frwda_w, data2_idex_frdb_w, instr_idex_exmem_w, imm_idex_alumux_w, rs_exmem_frwd_w, out_fwda_alu_w;
wire [31:0] out_fwdb_alumux_w, out_alu_exmem_w, aluin_alumux_alu_w, instr_address;
wire hd_ifid_w, flush_w, regDest_control_bubblemux_w, branch_control_bubblemux_w, memRead_control_bubblemux_w, memtoreg_control_bubblemux_w;
wire memWrite_control_bubblemux_w, alusrc_control_bubblemux_w, regWrite_control_bubblemux_w, jump_control_bubblemux_w, rW_memWB_reg_w;
wire flush_hazDet_bubbleMux_w, regdst_bM_idEx_w, alusrc_bM_idEx_w, regW_bM_idEx_w, memtoreg_bM_idEx_w, memwrite_bM_idEx_w, memread_bM_idEx_w;
wire branch_bM_idEx_w, jmp_bM_idEx_w, memread_idEx_haz_w, haz_pc_w, regdst_idex_wrmux_w, regwrite_idex_exmem_w;
wire memtoreg_idex_exmem_w, memwrite_idex_exmem_w, memread_idex_hz_w, branch_idex_exmem_w, jump_idex_exmem_w, rw_exmem_memwb_w, rw_memwb_fwd_w;
wire zero_alu_exmem_w, alusrc_idex_alumux_w;
wire [5:0] ifid_alucontr_w, ifid_cont_w, func_idex_aluctrl_w;
wire [4:0] rs_ifid_reg_w, rt_ifid_reg_w, wReg_memWB_reg_w, rs_idex_frwd_w, rd_idex_wrmux_w, rd_ifid_idex_w, rt_idEx_haz_w;
wire [4:0] out_reg_writeregmux_exmem_w, rd_exmem_fwd_w, rd_wb_fwd_w;
wire [15:0] imm_ifID_signExt_w;
wire [1:0] aluop_control_bubblemux_w, aluOP_bM_idEx_w, fwd_fwda_w, fwd_fwdb_w, aluOP_idex_aluctrl_w;
wire [3:0] alu_ctrl_alu_w;
wire [31:0] jump_addr_w, jump_addr_w2, jump_addr_w3, next_instr_exmem_pcmux_w, pcmux_pc_w;

pc_mux pcmux(.next_instr(pc4_ifid_w), .branch_addr(w_addr), .branch(branch_control_bubblemux_w), .instr(pcmux_pc_w));
pcplus4 pc(.instr(pcmux_pc_w), .pcwrite(haz_pc_w), .clk(clk), .next_instr(instr_address), .en(enable));
adder adder(.a(instr_address), .out(pc4_ifid_w));

//------------------------------------ID Stage-------------------------------------------------------
instr_mem instr_mem1(.address(instr_address), .instr(instr_ifid_w), .instr_in(instr_in));

ifid if_id(.instr(instr_ifid_w), .next_instr(pc4_ifid_w), .clk(clk), .ifdwrite(hd_ifid_w), .ifflush(flush_w), .op(ifid_cont_w),
        .out_next_instr(next_instr_ifid_idex_w), .ifid_rs(rs_ifid_reg_w), .ifid_rt(rt_ifid_reg_w), .ifid_rd(rd_ifid_idex_w),
         .imm(imm_ifID_signExt_w), .func(ifid_alucontr_w), .jump_addr(jump_addr_w));

main_controller main_control(.inst(), .opcode(ifid_cont_w), .ALUop(aluop_control_bubblemux_w), .RegDest(regDest_control_bubblemux_w),
                            .Branch(branch_control_bubblemux_w), .MemRead(memRead_control_bubblemux_w), .MemToReg(memtoreg_control_bubblemux_w),
                            .MemWrite(memWrite_control_bubblemux_w), .ALUsrc(alusrc_control_bubblemux_w), .RegWrite(regWrite_control_bubblemux_w),
                            .jump(jump_control_bubblemux_w));

register register(.in_data(regMux_register_w), .reg1(rs_ifid_reg_w), .reg2(rt_ifid_reg_w), .w_reg(rd_wb_fwd_w),
                         .reg_write(rw_memwb_fwd_w), .clk(clk), .data1(d1_reg_idEX_w), .data2(d2_reg_idEX_w));

sign_extend sign_extend (.inst(imm_ifID_signExt_w), .inst_out(signExt_idEX_w));

bubble_mux bubble_mux(.in_aluOP(aluop_control_bubblemux_w), .in_regdst(regDest_control_bubblemux_w), .in_alusrc(alusrc_control_bubblemux_w),
                        .in_regwrite(regWrite_control_bubblemux_w), .in_memtoreg(memtoreg_control_bubblemux_w), .in_memwrite(memWrite_control_bubblemux_w),
                        .in_memread(memRead_control_bubblemux_w), .in_branch(branch_control_bubblemux_w), .in_jump(jump_control_bubblemux_w),
                        .flush(flush_hazDet_bubbleMux_w), .aluOP(aluOP_bM_idEx_w), .regdst(regdst_bM_idEx_w), .alusrc(alusrc_bM_idEx_w),
                        .regwrite(regW_bM_idEx_w), .memtoreg(memtoreg_bM_idEx_w), .memwrite(memwrite_bM_idEx_w), .memread(memread_bM_idEx_w),
                        .branch(branch_bM_idEx_w), .jump(jmp_bM_idEx_w));

hazard hazard_det(.ifid_regRs(rs_ifid_reg_w), .ifid_regRt(rt_ifid_reg_w), .idex_regRt(rt_idEx_haz_w), .idex_memread(memread_idex_hz_w), .flush(flush_w),
                .ifdwrite(hd_ifid_w), .pcwrite(haz_pc_w), .bubble(flush_hazDet_bubbleMux_w));

instr_addr instr_adder(.imm(signExt_idEX_w), .next_instr(next_instr_ifid_idex_w), .add_instr(w_branch_addr));

compr compr(.data1(d1_reg_idEX_w), .data2(d2_reg_idEX_w), .branch(branch_control_bubblemux_w), .flush(flush_w), .pcsrc(w_branch));

pc_mux jump_mux(.next_instr(w_branch_addr), .branch_addr(jump_addr_w), .branch(jump_control_bubblemux_w), .instr(w_addr));
//------------------------------------EX Stage-------------------------------------------------------

idex id_ex(.clk(clk), .ifid_rs(rs_ifid_reg_w), .ifid_rt(rt_ifid_reg_w), .ifid_rd(rd_ifid_idex_w), .data1(d1_reg_idEX_w), .data2(d2_reg_idEX_w), 
        .imm(signExt_idEX_w), .next_instr(next_instr_ifid_idex_w), .in_aluOP(aluOP_bM_idEx_w), .in_regdst(regdst_bM_idEx_w), .in_alusrc(alusrc_bM_idEx_w),
        .in_regwrite(regW_bM_idEx_w), .in_memtoreg(memtoreg_bM_idEx_w), .in_memwrite(memwrite_bM_idEx_w), .in_memread(memread_bM_idEx_w), .in_branch(branch_bM_idEx_w),
        .in_jump(jmp_bM_idEx_w), .aluOP(aluOP_idex_aluctrl_w), .regdst(regdst_idex_wrmux_w), .alusrc(alusrc_idex_alumux_w), .regwrite(regwrite_idex_exmem_w),
        .memtoreg(memtoreg_idex_exmem_w), .memwrite(memwrite_idex_exmem_w), .memread(memread_idex_hz_w), .branch(branch_idex_exmem_w), .jump(jump_idex_exmem_w),
        .idex_rs(rs_idex_frwd_w), .idex_rt(rt_idEx_haz_w), .idex_rd(rd_idex_wrmux_w), .out_data1(data1_idex_frwda_w), .out_data2(data2_idex_frdb_w),
        .out_next_instr(instr_idex_exmem_w), .out_imm(imm_idex_alumux_w), .func(func_idex_aluctrl_w),
	 .jump_addr_in(), .jump_addr_out());

frwd_a fwd_a(.idex_rs(data1_idex_frwda_w), .exmem_rs(rs_exmem_frwd_w), .mem_data(regMux_register_w), .forward(fwd_fwda_w), .out_data(out_fwda_alu_w));
frwd_b fwd_b(.idex_rt(data2_idex_frdb_w), .exmem_rs(rs_exmem_frwd_w), .mem_data(regMux_register_w), .forward(fwd_fwdb_w), .out_data(out_fwdb_alumux_w));
alu_mux amux(.data_in(out_fwdb_alumux_w), .imm(imm_idex_alumux_w), .alusrc(alusrc_idex_alumux_w), .alu_in(aluin_alumux_alu_w));

writereg_mux wr_mux(.rt(rt_idEx_haz_w), .rd(rd_idex_wrmux_w), .regdst(regdst_idex_wrmux_w), .out_reg(out_reg_writeregmux_exmem_w));

forward_unit fwd(.ex_mem_rw(rw_exmem_memwb_w), .mem_wb_rw(rw_memwb_fwd_w), .id_ex_rs(rs_idex_frwd_w), .id_ex_rt(rt_idEx_haz_w), .ex_mem_rd(rd_exmem_fwd_w), .mem_wb_rd(rd_wb_fwd_w), 
        .fwd_a(fwd_fwda_w), .fwd_b(fwd_fwdb_w));

alu_control alu_ctrl(.func(func_idex_aluctrl_w), .aluOP(aluOP_idex_aluctrl_w), .alu_contr(alu_ctrl_alu_w));

alu alu_inst(.a(out_fwda_alu_w), .b(aluin_alumux_alu_w), .aluOP(alu_ctrl_alu_w), .result(out_alu_exmem_w),
        .zero());

//------------------------------------MEM Stage-------------------------------------------------------
wire memtoreg_exmem_memwb_w, branch_exmem_and_w, memread_exmem_datamem_w, memwrite_exmem_datamem_w, zero_w;
wire [31:0] data2_exmem_datamem_w, dataMem_memWB_w;

ex_mem_reg exmem(.reset(reset), .clk(clk), .regwrite_in(regwrite_idex_exmem_w), .MemtoReg_in(memtoreg_idex_exmem_w), .branch_in(branch_idex_exmem_w),
        .MemRead_in(memread_idex_hz_w), .MemWrite_in(memwrite_idex_exmem_w), .next_instr_in(instr_idex_exmem_w), 
        .alu_result_in(out_alu_exmem_w), .read_data2_in(out_fwdb_alumux_w), .write_reg_addr_in(out_reg_writeregmux_exmem_w), 
        .regwrite_out(rw_exmem_memwb_w), .MemtoReg_out(memtoreg_exmem_memwb_w), .branch_out(),
        .MemRead_out(memread_exmem_datamem_w), .MemWrite_out(memwrite_exmem_datamem_w), .next_instr_out(next_instr_exmem_pcmux_w),
        .alu_result_out(rs_exmem_frwd_w), .read_data2_out(data2_exmem_datamem_w), .write_reg_addr_out(rd_exmem_fwd_w),
	.jump_addr_in(), .jump_addr_out(), .zero_in(), .zero_out(), .jump_in());

data_mem datamem(.address(rs_exmem_frwd_w), .wr_data(data2_exmem_datamem_w), .MemWrite(memwrite_exmem_datamem_w),
        .MemRead(memread_exmem_datamem_w), .read_data(dataMem_memWB_w));

//------------------------------------WB Stage-------------------------------------------------------
wire [31:0] readData_memWB_regMux_w, address_memWB_regMux_w;
wire MemtoReg_memWB_regMux_w;

mem_wb_reg mem_wb_reg(.clk(clk), .reset(reset), .regwrite_in(rw_exmem_memwb_w), .MemtoReg_in(memtoreg_exmem_memwb_w), .read_data_in(dataMem_memWB_w), 
                        .address_in(rs_exmem_frwd_w), .write_reg_addr_in(rd_exmem_fwd_w), .read_data_out(readData_memWB_regMux_w), .address_out(address_memWB_regMux_w), 
			.regwrite_out(rw_memwb_fwd_w), .MemtoReg_out(MemtoReg_memWB_regMux_w), .write_reg_addr_out(rd_wb_fwd_w));

reg_mux regmux(.alu(address_memWB_regMux_w), .data_mem(readData_memWB_regMux_w), .memtoreg(MemtoReg_memWB_regMux_w), .data(regMux_register_w));

endmodule
