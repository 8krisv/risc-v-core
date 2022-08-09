

`timescale 1 ns/10 ps

module AXI_RAM_tb();


parameter ADDR_WIDTH = 10;



//////////// Input signals declarations ////////////
reg tb_clk_50;
reg tb_reset;
reg ram_read_ready;
reg ram_write_valid;
reg [ADDR_WIDTH-1:0] ram_addr;
reg [31:0] ram_input_data;


//////////// Output signals declarations ////////////
wire ram_read_valid;
wire ram_write_ready;
wire [31:0] ram_data_out;



/* Device Under Test (DUT) instantiation */
AXI_RAM #(.ADDR_WIDTH(ADDR_WIDTH)) Axi_ram (
//////////// INPUTS //////////
.AXI_RAM_Clk(tb_clk_50),
.AXI_RAM_Read_Ready(ram_read_ready),
.AXI_RAM_Write_Valid(ram_write_valid),
.AXI_RAM_Address(ram_addr), 
.AXI_RAM_Data_In(ram_input_data),
//////////// OUTPUT //////////
.AXI_RAM_Read_Valid(ram_read_valid),
.AXI_RAM_Write_Ready(ram_write_ready),
.AXI_RAM_Data_Out(ram_data_out)

);

//////////// create a 50Mhz clock //////////
always
begin
		tb_clk_50=1'b1;
		#10;
		tb_clk_50=1'b0;
		#10;
end


initial
begin

	ram_read_ready<=1'b0;
	ram_write_valid<=1'b0;
	ram_addr<=32'h00000000;
	ram_input_data<=32'h00000000;
	@(posedge tb_clk_50)
	ram_read_ready<=1'b0;
	ram_write_valid<=1'b1;
	ram_addr<=32'h00000000;
	ram_input_data<=32'h00000010;
	@(posedge tb_clk_50)
	@(posedge tb_clk_50)
	
	
	
	$stop;
	
	



end



endmodule
