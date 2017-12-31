`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/03 15:54:32
// Design Name: 
// Module Name: pipeidcu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipeidcu(mwreg,mrn,ern,ewreg,em2reg,mm2reg,rsrtequ,func,op,rs,rt,
wreg,m2reg,wmem,aluc,regrt,aluimm,fwda,fwdb,nostall,sext,pcsource,shift,jal,jalr,
compare,cpdone,lmem,smem);

input mwreg,ewreg,em2reg,mm2reg,rsrtequ;
input [4:0] mrn,ern,rs,rt;
input [5:0] func,op;
output wreg,m2reg,wmem,regrt,aluimm,sext,shift,jal;
//the jalr
output jalr;
output [3:0] aluc;
output [1:0] pcsource;
output [1:0] fwda,fwdb;//foewarding
output nostall; //stall pipeline due to lw dependent

output [1:0] compare;//use to compare the value
input cpdone;//use to judge whether the compare is successful

output [2:0] lmem;// get bit
output [1:0] smem;//save bit


reg [1:0] fwda,fwdb;
//R
wire r_type,i_add,i_addu,i_sub,i_subu,i_and,
i_mult,i_multu,i_div,i_divu,i_mfhi,i_mflo,i_mthi,i_mtlo,i_mfc0,i_mtc0,
i_or,i_xor,i_nor,i_slt,i_sltu,i_sll,i_srl,i_sra,i_sllv,i_srlv,i_srav,i_jr,
i_jalr,i_break,i_syscall,i_eret;
//I
wire i_addi,i_addiu,i_andi,i_ori,i_xori,i_lb,i_lbu,i_lh,i_lhu,i_sb,i_sh,i_lw,i_sw,i_beq,i_bne,i_lui,
i_bltz,i_bgez,i_blez,i_bgtz,i_bltzal,i_bgezal,i_slti,i_sltiu;
//J
wire i_j,i_jal;
//R-TYPE
and(r_type,~op[5],~op[4],~op[3],~op[2],~op[1],~op[0]);
and(i_add,r_type,func[5],~func[4],~func[3],~func[2],~func[1],~func[0]);//100000
and(i_addu,r_type,func[5],~func[4],~func[3],~func[2],~func[1], func[0]);//100001
and(i_sub,r_type,func[5],~func[4],~func[3],~func[2], func[1],~func[0]);//100010
and(i_subu,r_type,func[5],~func[4],~func[3],~func[2], func[1], func[0]);//100011
and(i_mult,r_type,~func[5], func[4], func[3],~func[2],~func[1],~func[0]);//011000
and(i_multu,r_type,~func[5], func[4], func[3],~func[2],~func[1], func[0]);//011001
and(i_div,r_type,~func[5], func[4], func[3],~func[2], func[1],~func[0]);//011010
and(i_divu,r_type,~func[5], func[4], func[3],~func[2], func[1], func[0]);//011011
and(i_mfhi,r_type,~func[5], func[4],~func[3],~func[2],~func[1],~func[0]);//010000
and(i_mflo,r_type,~func[5], func[4],~func[3],~func[2], func[1],~func[0]);//010010
and(i_mthi,r_type,~func[5], func[4],~func[3],~func[2],~func[1], func[0]);//010001
and(i_mtlo,r_type,func[5],~func[4],~func[3],~func[2], func[1],~func[0]);//010011
and(i_mfc0,~op[5], op[4],~op[3],~op[2],~op[1],~op[0],~rs[2],~func[5],~func[4],~func[3]);//op = 010000 000sel
and(i_mtc0,~op[5], op[4],~op[3],~op[2],~op[1],~op[0],rs[2],~func[5],~func[4],~func[3]);//op = 010000 000sel
and(i_xor,r_type,func[5],~func[4],~func[3], func[2], func[1],~func[0]);//100110
and(i_and,r_type,func[5],~func[4],~func[3], func[2],~func[1],~func[0]);//100100
and(i_or,r_type,func[5],~func[4],~func[3], func[2],~func[1], func[0]);//100101
and(i_nor,r_type,func[5],~func[4],~func[3], func[2], func[1], func[0]);//100111
and(i_slt,r_type, func[5],~func[4], func[3],~func[2], func[1],~func[0]);//101010
and(i_sltu,r_type, func[5],~func[4], func[3],~func[2], func[1], func[0]);//101011
and(i_sll,r_type,~func[5],~func[4],~func[3],~func[2],~func[1],~func[0]);//000000
and(i_sra,r_type,~func[5],~func[4],~func[3],~func[2], func[1], func[0]);//000011
and(i_srl,r_type,~func[5],~func[4],~func[3],~func[2], func[1],~func[0]);//000010
and(i_sllv,r_type,~func[5],~func[4],~func[3], func[2],~func[1],~func[0]);//000100
and(i_srav,r_type,~func[5],~func[4],~func[3], func[2], func[1], func[0]);//000111
and(i_srlv,r_type,~func[5],~func[4],~func[3], func[2], func[1],~func[0]);//000110
and(i_jr,r_type,~func[5],~func[4], func[3],~func[2],~func[1],~func[0]);//001000
and(i_jalr,r_type,~func[5],~func[4], func[3],~func[2],~func[1], func[0]);//001001
and(i_syscall,r_type,~func[5],~func[4], func[3], func[2],~func[1],~func[0]);//001100
and(i_break,r_type,~func[5],~func[4], func[3], func[2],~func[1], func[0]);//001101
and(i_eret,~op[5], op[4],~op[3],~op[2],~op[1],~op[0],~func[5], func[4], func[3],~func[2],~func[1],~func[0]);//010000 011000
//I-TYPE
and (i_addi,~op[5],~op[4], op[3],~op[2],~op[1],~op[0]);//001000
and (i_addiu,~op[5],~op[4], op[3],~op[2],~op[1], op[0]);//001001
and (i_xori,~op[5],~op[4], op[3], op[2], op[1],~op[0]);//001110
and (i_andi,~op[5],~op[4], op[3], op[2],~op[1],~op[0]);//001100
and (i_ori,~op[5],~op[4], op[3], op[2],~op[1], op[0]);//001101
and (i_lui,~op[5],~op[4], op[3], op[2], op[1], op[0]);//001111
and (i_lb, op[5],~op[4],~op[3],~op[2],~op[1],~op[0]);//100000
and (i_lbu, op[5],~op[4],~op[3], op[2],~op[1],~op[0]);//100100
and (i_lh, op[5],~op[4],~op[3],~op[2],~op[1], op[0]);//100001
and (i_lhu, op[5],~op[4],~op[3], op[2],~op[1], op[0]);//100101
and (i_sb, op[5],~op[4], op[3],~op[2],~op[1],~op[0]);//101000
and (i_sh, op[5],~op[4], op[3],~op[2],~op[1], op[0]);//101001
and (i_lw, op[5],~op[4],~op[3],~op[2], op[1], op[0]);//100011
and (i_sw, op[5],~op[4], op[3],~op[2], op[1], op[0]);//101011
and (i_beq,~op[5],~op[4],~op[3], op[2],~op[1],~op[0]);//000100
and (i_bne,~op[5],~op[4],~op[3], op[2],~op[1], op[0]);//000101
and (i_bltz,~op[5],~op[4],~op[3],~op[2],~op[1], op[0],~rt[4],~rt[0]);//000001,000000
and (i_bgez,~op[5],~op[4],~op[3],~op[2],~op[1], op[0],~rt[4], rt[0]);//000001,000001
and (i_blez,~op[5],~op[4],~op[3], op[2], op[1],~op[0]);//000110
and (i_bgtz,~op[5],~op[4],~op[3], op[2], op[1], op[0]);//000111
and (i_bltzal,~op[5],~op[4],~op[3],~op[2],~op[1], op[0], rt[4],~rt[0]);//000001,100000
and (i_bgezal,~op[5],~op[4],~op[3],~op[2],~op[1], op[0], rt[4], rt[0]);//000001,100001
and (i_slti,~op[5],~op[4], op[3],~op[2], op[1],~op[0]);//001010
and (i_sltiu,~op[5],~op[4], op[3],~op[2], op[1], op[0]);//001011
//J-TYPE
and (i_j,~op[5],~op[4],~op[3],~op[2], op[1],~op[0]);//000010
and (i_jal,~op[5],~op[4],~op[3],~op[2], op[1], op[0]);//000011

wire i_rs = i_add | i_addu | i_sub | i_subu | i_mult | i_multu | i_div | i_divu | i_mthi | 
i_mtlo | i_xor | i_and | i_or | i_nor | i_slt | i_sltu | i_sllv | i_srav | i_srlv |
i_jr | i_jalr | i_addi | i_addiu | i_xori | i_andi | i_ori | i_lb | i_lbu | i_lh | i_lhu | 
i_sb | i_sh | i_lw | i_sw | i_beq | i_bne | i_bltz | i_bgez | i_blez | i_bgtz | i_bltzal | 
i_bgezal | i_slti | i_sltiu ;
wire i_rt = i_add | i_addu | i_sub | i_subu | i_mult | i_multu | i_div | i_divu | i_mfc0 | 
i_mtc0 | i_xor | i_and | i_or | i_nor | i_slt | i_sltu | i_sll | i_sra | i_srl | i_sllv | 
i_srav | i_srlv | i_addi | i_addiu | i_xori | i_andi | i_ori | i_lui | i_lb | i_lbu | i_lh | 
i_lhu | i_sb | i_sh | i_lw | i_sw | i_beq | i_bne | i_slti | i_sltiu;
//whether there is a sign waiting to write into reg which may cause the conflict
//wpcir
assign nostall = ~(ewreg & em2reg & (ern != 0) & (i_rs & (ern == rs) | i_rt & (ern == rt)));

always @ (ewreg or mwreg or ern or mrn or em2reg or mm2reg or rs or rt)begin
         fwda = 2'b00;//default forward a: no hazards
         if (ewreg & (ern != 0) & (ern == rs) & ~em2reg) begin
              fwda = 2'b01;//select exe_alu
         end else begin
              if (mwreg & (mrn != 0) & (mrn == rs) & ~mm2reg) begin
                   fwda = 2'b10;//select mem_alu
              end else begin
                   if (mwreg & (mrn != 0) & (mrn == rs) & mm2reg) begin
                        fwda = 2'b11;//select mem_lw
                   end
              end
         end
         fwdb = 2'b00;//default forward b: no hazards
         if (ewreg & (ern != 0) & (ern == rt) & ~em2reg) begin
              fwdb = 2'b01;//select exe_alu
         end else begin
              if (mwreg & (mrn != 0) & (mrn == rt) & ~mm2reg) begin
                   fwdb = 2'b10;//select mem_alu
              end else begin
                   if (mwreg & (mrn != 0) & (mrn == rt) & mm2reg)begin
                         fwdb = 2'b11; //select mem_lw
                   end
              end
         end
end
//write the reg
assign wreg = (i_add | i_addu | i_sub | i_subu | i_and | i_mfhi | i_mflo | i_or | i_xor | 
i_nor | i_slt | i_sltu | i_sll | i_srl | i_sra | i_sllv | i_srlv | i_srav | i_jalr | 
i_addi | i_addiu | i_andi | i_ori | i_xori | i_lui | i_lb | i_lbu | i_lh | i_lhu | i_lw | 
i_bgezal | i_bltzal | i_slti | i_sltiu | i_jal) & nostall;
//write to rt rather than rd
assign regrt = i_mfc0 | i_addi | i_addiu | i_andi | i_ori | i_xori | i_lui | i_lb | i_lbu | 
i_lh | i_lhu |i_lw | i_slti | i_sltiu;
//write to $31
assign jal = i_jalr | i_jal | cpdone & (i_bgezal | i_bltzal);
//write to rd
assign jalr = i_jalr;
//find in the memory first
assign m2reg = i_lb | i_lbu | i_lh | i_lhu |i_lw;
//using the shamt
assign shift = i_sll | i_srl | i_sra;
//using the immediate or the offset(low 16)
assign aluimm = i_addi | i_addiu | i_andi | i_ori | i_xori | i_lw | i_lui | i_sw | i_lb | i_lbu | 
i_lh | i_lhu | i_sb | i_sh | i_slti | i_sltiu;
//need the operation of [sign-extend]
assign sext = i_addi | i_addiu | i_lb | i_lh | i_sb | i_sh | i_lw | i_sw | i_slti | i_beq | i_bgez |
i_bgezal | i_bgtz | i_blez | i_bltz | i_bltzal | i_bne;
//alu control

assign aluc [3] = i_sra | i_addu | i_lbu | i_lhu | i_addiu | i_subu | i_nor | i_srav |
 i_sltu | i_sltiu | i_slti | i_slt;
assign aluc [2] = i_sra | i_srl | i_lui | i_or | i_ori | i_sub | i_subu | i_srav | i_srlv;
assign aluc [1] = i_sra | i_srl | i_lui | i_sll | i_xor | i_xori | i_nor | i_sllv | i_srav | 
i_srlv | i_sltu | i_sltiu;
assign aluc [0] = i_sra | i_srl | i_or | i_ori | i_sll | i_and | i_andi | i_sllv | i_srav | 
i_srlv | i_slt | i_slti | i_sltu | i_sltiu;

assign wmem = (i_sw | i_sb | i_sh )& nostall;
//compare
assign compare [1] = i_blez | i_bltz | i_bltzal;
assign compare [0] = i_bgtz | i_bltz | i_bltzal;
assign pcsource [1] = i_jr | i_j | i_jal | i_jalr;
assign pcsource [0] = i_beq & rsrtequ | i_bne & ~rsrtequ | i_j | i_jal | 
((i_bgez | i_bgezal | i_bgtz | i_blez | i_bltz |i_bltzal) & cpdone);
//lmem and smem
assign lmem [0] = i_lb | i_lbu;
assign lmem [1] = i_lh | i_lhu;
assign lmem [2] = i_lbu | i_lhu;
assign smem [0] = i_sb;
assign smem [1] = i_sh;
endmodule
